import 'package:flutter/material.dart';

abstract class BaseNavigator {
  void showLoadingDialog({String? message = 'Loading...'}) {}
  void hideLoadingDialog() {}
  void showMessage(
    String message, {
    bool isDismissible = true,
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {}
}

class BaseViewModel<Nav extends BaseNavigator> extends ChangeNotifier {
  Nav? navigator;
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
   late VM viewModel;
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
    viewModel.navigator = this;
  }

  VM initViewModel();

  @override
  void showLoadingDialog({String? message = 'Loading...'}) {}
  @override
  void hideLoadingDialog() {}
  @override
  void showMessage(
    String message, {
    bool isDismissible = true,
    String? posActionTitle,
    String? negActionTitle,
    VoidCallback? posAction,
    VoidCallback? negAction,
  }) {
    showMessage(
      message,
      posActionTitle: posActionTitle,
      negActionTitle: negActionTitle,
      posAction: posAction,
      negAction: negAction,
      isDismissible: isDismissible,
    );
  }
}
