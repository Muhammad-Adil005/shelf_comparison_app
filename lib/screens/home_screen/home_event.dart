import 'package:flutter/cupertino.dart';

abstract class HomeEvent {}

class GotoNextScreen extends HomeEvent {
  final BuildContext context;

  GotoNextScreen({
    required this.context,
  });
}
