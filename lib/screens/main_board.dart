import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_app/provider/store_provider.dart';
import 'package:responsive_app/screens/board/favorites.dart';
import 'package:responsive_app/screens/board/home.dart';
import 'package:responsive_app/screens/board/orders.dart';
import 'package:responsive_app/screens/board/profile.dart';
import 'package:responsive_app/utils/ui.dart';
import 'package:responsive_app/widgets/system/nav_bar.dart';
import 'package:responsive_app/widgets/system/side_bar.dart';

class MainBoard extends StatefulWidget {
  static const String routeName = "/main-board";

  const MainBoard({Key? key}) : super(key: key);

  @override
  State<MainBoard> createState() => _MainBoardState();
}

class _MainBoardState extends State<MainBoard> {
  bool _isLoading = false;

  /// the app layout
  /// Left panel for tablet and bottom nav for mobile
  late Widget layout;

  /// the app navigation bar
  late NavBar navBar;

  /// list of different view
  final List<Widget> _boards = [
    const HomeBoard(),
    const Favorites(),
    const Orders(),
    const Profile()
  ];

  /// stored the current view index
  int _currentBoard = 0;

  @override
  void initState() {
    super.initState();
    navBar = NavBar(
      onChange: (p0) => setState(() => _currentBoard = p0),
    );
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _fetchData() {
    try {
      _isLoading = true;
      Future.delayed(const Duration(seconds: 2)).then((value) {
        Provider.of<StoreProvider>(context, listen: false).loadData();
      });
    } catch (e) {
      print("Error...$e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: SafeArea(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    /// the content displayed inside the layout
    final Widget content = _boards[_currentBoard];

    if (isMobile) {
      layout = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 18),
              child: content,
            ),
          ),
          navBar
        ],
      );
    } else {
      layout = Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          navBar,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 24),
              child: content,
            ),
          ),
          const SideBar(),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(child: layout),
    );
  }
}
