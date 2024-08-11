import 'package:bilivideo_down/views/pages/download/download_complete_page.dart';
import 'package:bilivideo_down/views/pages/download/downloading_page.dart';
import 'package:bilivideo_down/views/pages/download/wait_download_page.dart';
import 'package:bilivideo_down/window_config/window_buttons.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';

class DownloadNavigation extends StatefulWidget {
  const DownloadNavigation({super.key});
  @override
  State<DownloadNavigation> createState() => DownloadTabsPageState();
}

class DownloadTabsPageState extends State<DownloadNavigation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(30),
          child: DragToMoveArea(
            child: AppBar(
              actions: const [WindowButtons()],
            ),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TabBar(
                    controller: _tabController,
                    labelColor: Theme.of(context).colorScheme.secondary,
                    unselectedLabelColor:
                        Theme.of(context).unselectedWidgetColor,
                    tabs: const [
                      Tab(text: '待下载'),
                      Tab(text: '下载中'),
                      Tab(text: '已下载'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                Center(child: WaitDownloadPage()),
                Center(child: DownloadingPage()),
                Center(child: VideoDownCompletePage()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void navigateToTab(int index) {
    _tabController.animateTo(index);
  }
}
