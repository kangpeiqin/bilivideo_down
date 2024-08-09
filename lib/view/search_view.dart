import 'package:bilivideo_down/constant/constant.dart';
import 'package:bilivideo_down/provider/video_search_provider.dart';
import 'package:bilivideo_down/view/video_list_view.dart';
import 'package:bilivideo_down/window_config/window_buttons.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchView extends ConsumerWidget {
  const SearchView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalKey inputKey = GlobalKey();
    final videoState = ref.watch(videoSearchProvider);
    final searchService = ref.read(videoSearchProvider.notifier);
    final TextEditingController searchController = TextEditingController();
    //错误消息提示
    if (videoState.error != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(videoState.error!),
          ),
        );
      });
    }
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(30),
        child: DragToMoveArea(
          child: AppBar(actions: const [WindowButtons()]),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              width: 430,
              child: Image(
                image: AssetImage(Constant.logoImagePath),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 450,
                  child: TextField(
                    key: inputKey,
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: '请输入B站视频链接',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                  ),
                  onPressed: () {
                    final input = searchController.text.trim();
                    searchService.handleSearch(input);
                  },
                  child: const Text('搜索'),
                )
              ],
            ),
            const SizedBox(height: 25),
            videoState.episodes.isNotEmpty
                ? SizedBox(
                    width: 580,
                    child: VideoListView(
                      inputKey: inputKey,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
