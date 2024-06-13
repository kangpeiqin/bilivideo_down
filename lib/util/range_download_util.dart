import 'dart:io';
import 'package:dio/dio.dart';

typedef ProgressCallback = void Function(int received, int total);

class RangeDownloadUtil {
  static Future<Response> downloadWithChunks(
    String url,
    String savePath, {
    bool isRangeDownload = true,
    required ProgressCallback onReceiveProgress,
    int maxChunk = 2,
    required Dio dio,
    required CancelToken cancelToken,
  }) async {
    const firstChunkSize = 102;
    int total = 0;
    var progress = <int>[];
    var progressInit = <int>[];

    Future<void> mergeTempFiles(int chunk) async {
      File f = File("${savePath}temp0");
      IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
      for (int i = 1; i < chunk; ++i) {
        File f0 = File("${savePath}temp$i");
        await ioSink.addStream(f0.openRead());
        await f0.delete();
      }
      await ioSink.close();
      await f.rename(savePath);
    }

    Future<void> mergeFiles(
        String file1, String file2, String targetFile) async {
      File f1 = File(file1);
      File f2 = File(file2);
      IOSink ioSink = f1.openWrite(mode: FileMode.writeOnlyAppend);
      await ioSink.addStream(f2.openRead());
      await f2.delete();
      await ioSink.close();
      await f1.rename(targetFile);
    }

    ProgressCallback createCallback(int no) {
      return (int received, int rangeTotal) async {
        if (received >= rangeTotal) {
          var path = "${savePath}temp$no";
          var oldPath = "${savePath}temp${no}_pre";
          File oldFile = File(oldPath);
          if (oldFile.existsSync()) {
            await mergeFiles(oldPath, path, path);
          }
        }
        progress[no] = progressInit[no] + received;
        if (total != 0) {
          onReceiveProgress(progress.reduce((a, b) => a + b), total);
        }
      };
    }

    Future<Response> downloadChunk(String url, int start, int end, int no,
        {bool isMerge = true}) async {
      int initLength = 0;
      --end;
      var path = "${savePath}temp$no";
      File targetFile = File(path);
      if (await targetFile.exists() && isMerge) {
        if (start + await targetFile.length() < end) {
          initLength = await targetFile.length();
          start += initLength;
          var preFile = File("${path}_pre");
          if (await preFile.exists()) {
            initLength += await preFile.length();
            start += await preFile.length();
            await mergeFiles(preFile.path, targetFile.path, preFile.path);
          } else {
            await targetFile.rename(preFile.path);
          }
        } else {
          await targetFile.delete();
        }
      }
      progress.add(initLength);
      progressInit.add(initLength);
      return dio.download(
        url,
        path,
        onReceiveProgress: createCallback(no),
        options: Options(
          headers: {"range": "bytes=$start-$end"},
        ),
        deleteOnError: false,
        cancelToken: cancelToken,
      );
    }

    if (isRangeDownload) {
      Response response =
          await downloadChunk(url, 0, firstChunkSize, 0, isMerge: false);
      if (response.statusCode == 206) {
        total = int.parse(response.headers
            .value(HttpHeaders.contentRangeHeader)!
            .split("/")
            .last);
        int reserved = total -
            int.parse(response.headers.value(HttpHeaders.contentLengthHeader)!);
        int chunk = (reserved / firstChunkSize).ceil() + 1;
        if (chunk > 1) {
          int chunkSize = firstChunkSize;
          if (chunk > maxChunk + 1) {
            chunk = maxChunk + 1;
            chunkSize = (reserved / maxChunk).ceil();
          }
          var futures = <Future>[];
          for (int i = 0; i < maxChunk; ++i) {
            int start = firstChunkSize + i * chunkSize;
            int end = (i == maxChunk - 1) ? total : start + chunkSize;
            futures.add(downloadChunk(url, start, end, i + 1));
          }
          await Future.wait(futures);
        }
        await mergeTempFiles(chunk);
        return Response(
            statusCode: 200,
            statusMessage: "success",
            requestOptions: RequestOptions(path: url));
      } else if (response.statusCode == 200) {
        return dio.download(
          url,
          savePath,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          deleteOnError: false,
        );
      } else {
        throw Exception(
            "Unhandled response status code: ${response.statusCode}");
      }
    } else {
      return dio.download(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
      );
    }
  }
}
