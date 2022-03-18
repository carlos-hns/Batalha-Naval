import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel {
  final BehaviorSubject<bool> _state = BehaviorSubject.seeded(false);
  Stream<bool> get isBusy => this._state.stream;

  bool isActive = true;

  void setStateToBusy() => this._state.add(true);
  void setStateToReady() => this._state.add(false);

  void dispose() {}
  void onResume() {}
  void onPause() {}
}
