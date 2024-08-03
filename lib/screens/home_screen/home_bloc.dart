import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import '../../routes/routes.dart';
import 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    registerEvents();
  }

  void registerEvents() {
    on<GotoNextScreen>(_onGotoNextScreen);
  }

  Future<void> _onGotoNextScreen(
      GotoNextScreen event, Emitter<HomeState> emit) async {
    Navigator.pushNamed(event.context, Routes.uploadReferenceScreen);
  }
}
