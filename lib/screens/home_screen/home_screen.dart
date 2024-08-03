import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shelf_comparison_app/screens/home_screen/home.dart';

import '../../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => HomeBloc(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Shelf Comparison App'),
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return Center(
              child: CustomButton(
                buttonText: 'Upload Reference Planogram',
                onPressed: () {
                  context
                      .read<HomeBloc>()
                      .add(GotoNextScreen(context: context));
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
