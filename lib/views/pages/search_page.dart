import 'package:bilivideo_down/constant/constant.dart';
import 'package:bilivideo_down/controller/bili_video_search_controller.dart';
import 'package:bilivideo_down/views/widget/collapse_widget.dart';
import 'package:bilivideo_down/window_config/window_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    GlobalKey inputKey = GlobalKey();
    var searchController = Get.find<BiliVideoSearchController>();
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: DragToMoveArea(
            child: AppBar(actions: const [WindowButtons()]),
          )),
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
                    controller: searchController.controller,
                    // key: inputKey,
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
                  onPressed: searchController.isLoading.isFalse
                      ? () {
                          searchController.handleSearch(
                              searchController.controller.text,
                              context,
                              inputKey);
                        }
                      : null,
                  child: const Text('搜索'),
                )
              ],
            ),
            const SizedBox(height: 25),
            Obx(
              () => searchController.episodeList.isNotEmpty
                  ? SizedBox(
                      width: 580,
                      child: CollapseWidget(
                        inputKey: inputKey,
                      ),
                    )
                  : const SizedBox.shrink(),
            )
          ],
        ),
      ),
    );
  }
}
