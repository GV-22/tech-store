import 'package:flutter/cupertino.dart';

class UiProvider with ChangeNotifier {
  bool _isSideBarOpened = false;

  bool get isSideBarOpened => _isSideBarOpened;

  void setSideBarState(bool isOpened) {
    _isSideBarOpened = isOpened;
  }
}