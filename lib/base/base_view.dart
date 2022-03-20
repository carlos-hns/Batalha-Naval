import 'package:flutter/material.dart';
import '../injection.dart';
import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  /// If true, will trigger the onInitState for every Build call
  final bool shouldRefresh;
  final Function(T)? onInitState;
  final Function(T)? onDispose;
  final Widget Function(BuildContext context, T viewModel) builder;

  BaseView({
    Key? key,
    required this.builder,
    this.shouldRefresh = false,
    this.onInitState,
    this.onDispose,
  }) : super(key: key);

  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> {
  late T _viewModel;

  @override
  void initState() {
    super.initState();

    this._viewModel = getIt<T>();

    if (this.widget.onInitState != null) {
      this.widget.onInitState!(this._viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return this.widget.builder(context, _viewModel);
  }

  @override
  void dispose() {
    if (this.widget.onDispose != null) {
      this.widget.onDispose!(this._viewModel);
    } else {
      this._viewModel.dispose();
    }

    super.dispose();
  }
}
