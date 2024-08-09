import 'package:bilivideo_down/view/search_view.dart';
import 'package:bilivideo_down/views/nav/desk_navigate.dart';
import 'package:bilivideo_down/views/nav/download_nav.dart';
import 'package:bilivideo_down/views/pages/search_page.dart';
import 'package:bilivideo_down/views/pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouterPath {
  static const String search = "/search";

  static const String download = "/download";

  static const String settings = "/setting";

  static final List<String> pagesRoutePaths = [
    search,
    download,
    settings,
  ];
}

final GoRouter routerConfig = GoRouter(
  initialLocation: RouterPath.search,
  routes: <RouteBase>[
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return DeskNavigation(content: child);
      },
      routes: [
        GoRoute(
          path: RouterPath.search,
          builder: (BuildContext context, GoRouterState state) =>
              // const SearchPage(),
              const SearchView(),
        ),
        GoRoute(
          path: RouterPath.download,
          builder: (BuildContext context, GoRouterState state) {
            return const DownloadNavigation();
          },
        ),
        GoRoute(
          path: RouterPath.settings,
          builder: (BuildContext context, GoRouterState state) =>
              const SettingsPage(),
        )
      ],
    ),
  ],
);
