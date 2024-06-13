import 'package:bilivideo_down/router/router_config.dart';
import 'package:bilivideo_down/views/widget/theme_switch_icon.dart';
import 'package:bilivideo_down/window_config/windows_adapter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeskNavigation extends StatelessWidget {
  final Widget content;

  const DeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          //侧栏组件
          const DeskNavigationRail(),
          //内容组件
          Expanded(child: content),
        ],
      ),
    );
  }
}

class DeskNavigationRail extends StatefulWidget {
  const DeskNavigationRail({super.key});

  @override
  State<DeskNavigationRail> createState() => _DeskNavigationRailState();
}

class _DeskNavigationRailState extends State<DeskNavigationRail> {
  // 导航列表
  final List<NavigationRailDestination> destinations = const [
    NavigationRailDestination(icon: Icon(Icons.search), label: Text("搜索")),
    NavigationRailDestination(icon: Icon(Icons.download), label: Text("下载")),
    NavigationRailDestination(icon: Icon(Icons.settings), label: Text("设置")),
  ];

  //创建 widget
  @override
  Widget build(BuildContext context) {
    final activeIndex = _getCurrentActiveIndex();
    return DragToMoveArea(
        child: NavigationRail(
      leading: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          _onDestinationSelected(0);
        },
        child: const Icon(Icons.home),
      ),
      trailing: const ThemeSwitchIcon(),
      onDestinationSelected: _onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      destinations: destinations,
      selectedIndex: activeIndex,
    ));
  }

  final RegExp _segReg = RegExp(r'/\w+');
  int _getCurrentActiveIndex() {
    final String path = GoRouterState.of(context).uri.toString();
    RegExpMatch? match = _segReg.firstMatch(path);
    if (match == null) return 0;
    String? target = match.group(0);
    int index = RouterPath.pagesRoutePaths
        .indexWhere((menu) => menu.contains(target ?? ''));
    return index == -1 ? 0 : index;
  }

  void _onDestinationSelected(int index) {
    if (index < RouterPath.pagesRoutePaths.length) {
      context.replace(RouterPath.pagesRoutePaths[index]);
    }
  }
}
