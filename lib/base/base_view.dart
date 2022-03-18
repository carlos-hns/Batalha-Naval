import 'package:batalha_naval/base/app_route_observer.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import '../injection.dart';
import 'base_view_model.dart';

class BaseView<T extends BaseViewModel> extends StatefulWidget {
  /// If true, will trigger the onInitState for every Build call
  final bool shouldRefresh;
  final Function(T)? onInitState;
  final Function(T)? onDispose;
  final Function(T)? onAppClose;
  final void Function(T)? onFocusLost;
  final void Function(T)? onFocusGained;
  final void Function(T)? onVisibilityLost;
  final void Function(T)? onVisibilityGained;
  final void Function(T)? onForegroundLost;
  final void Function(T)? onForegroundGained;
  final Function()? afterBuildOnce;
  final Widget Function(BuildContext context, T viewModel) builder;

  BaseView({
    Key? key,
    required this.builder,
    this.shouldRefresh = false,
    this.onInitState,
    this.onDispose,
    this.onAppClose,
    this.onFocusLost,
    this.onFocusGained,
    this.onVisibilityLost,
    this.onForegroundGained,
    this.onForegroundLost,
    this.onVisibilityGained,
    this.afterBuildOnce,
  }) : super(key: key);

  _BaseViewState<T> createState() => _BaseViewState<T>();

  static AppRouteObserver ofRouteObserver() => getIt<AppRouteObserver>();
}

class _BaseViewState<T extends BaseViewModel> extends State<BaseView<T>> with WidgetsBindingObserver {
  late T _viewModel;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) => this.widget.afterBuildOnce?.call());
    WidgetsBinding.instance?.addObserver(this);

    this._viewModel = getIt<T>();

    if (this.widget.onInitState != null) {
      this.widget.onInitState!(this._viewModel);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (AppLifecycleState.detached == state && this.widget.onAppClose != null) {
      this.widget.onAppClose!(this._viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.shouldRefresh && this.widget.onInitState != null) {
      this.widget.onInitState!(this._viewModel);
    }

    return FocusDetector(
        onFocusLost: () => this.widget.onFocusLost?.call(this._viewModel),
        onFocusGained: () => this.widget.onFocusGained?.call(this._viewModel),
        onVisibilityLost: () {
          this._viewModel.isActive = false;
          this.widget.onVisibilityLost?.call(this._viewModel);
          this._viewModel.onPause();
        },
        onVisibilityGained: () {
          this._viewModel.isActive = true;
          this.widget.onVisibilityGained?.call(this._viewModel);
          this._viewModel.onResume();
        },
        onForegroundLost: () => this.widget.onForegroundLost?.call(this._viewModel),
        onForegroundGained: () => this.widget.onForegroundGained?.call(this._viewModel),
        child: this.widget.builder(context, this._viewModel));
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);

    if (this.widget.onDispose != null) {
      this.widget.onDispose!(this._viewModel);
    } else {
      this._viewModel.dispose();
    }

    super.dispose();
  }
}
