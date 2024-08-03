import 'package:flutter/material.dart';

import 'routes/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const ScrollBehavior().copyWith(overscroll: false),
      debugShowCheckedModeBanner: false,
      title: 'Shelf Comparison App',
      initialRoute: Routes.initial,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
