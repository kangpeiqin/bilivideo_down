import 'package:bilivideo_down/model/video_info.dart';
import 'package:common_utils/common_utils.dart';
import 'package:sqflite/sqflite.dart';

class VideoInfoDao {
  final Database db;

  VideoInfoDao(this.db);

  Future<int> insert(VideoInfo videoInfo) async {
    String addSql = "INSERT INTO "
        "video_info(bvid,aid,cid,pic,title,pubdate,ctime,desc,duration,downloadStatus,playUrl,length,size,location,created,updated) "
        "VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);";
    try {
      return await db.transaction((tran) async => await tran.rawInsert(addSql, [
            videoInfo.bvid,
            videoInfo.aid,
            videoInfo.cid,
            videoInfo.pic,
            videoInfo.title,
            videoInfo.pubdate,
            videoInfo.ctime,
            videoInfo.desc,
            videoInfo.duration,
            videoInfo.downloadStatus,
            videoInfo.playUrl,
            videoInfo.length,
            videoInfo.size,
            videoInfo.location,
            DateTime.now().toIso8601String(),
            DateTime.now().toIso8601String()
          ]));
    } catch (e) {
      LogUtil.v('Insert error: $e');
      return Future.error('Database insert error: $e');
    }
  }

  Future<int> updateDownloadStatus(String bvid, String downloadStatus) async {
    String updateSql =
        "UPDATE video_info SET downloadStatus=?,updated=? WHERE bvid = ?";
    return await db
        .transaction((tran) async => await tran.rawUpdate(updateSql, [
              downloadStatus,
              DateTime.now().toIso8601String(),
              bvid,
            ]));
  }

  Future<bool> existByBvid(String bvid) async {
    String sql = "SELECT COUNT(bvid) as count FROM video_info "
        "WHERE bvid = ?";
    List<Map<String, dynamic>> rawData = await db.rawQuery(sql, [bvid]);
    if (rawData.isNotEmpty) {
      return rawData[0]['count'] > 0;
    }
    return false;
  }

  Future<void> deleteByBvid(String bvid) async {
    return await db.execute(
        "DELETE FROM video_info "
        "WHERE bvid = ?",
        [bvid]);
  }

  Future<void> clear() async {
    return await db.execute("DELETE FROM video_info");
  }

  Future<List<VideoInfo>> queryAll() async {
    List<Map<String, dynamic>> data = await db.rawQuery(
        "SELECT bvid,aid,cid,pic,title,pubdate,ctime,`desc`,duration,downloadStatus,playUrl,length,size,location "
        "FROM video_info "
        "ORDER BY created desc");
    List<VideoInfo> result = data.map((e) => VideoInfo.fromJson(e)).toList();
    return result;
  }
}
