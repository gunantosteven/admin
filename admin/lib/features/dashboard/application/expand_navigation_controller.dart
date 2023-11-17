import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'expand_navigation_controller.g.dart';

@riverpod
class ExpandNavigationController extends _$ExpandNavigationController {
  @override
  bool build() {
    return false;
  }

  void expand() {
    state = !state;
  }
}
