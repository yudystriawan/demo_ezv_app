import 'package:demo_ezv_app/features/products/data/datasources/hive/query_model.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:demo_ezv_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  configureDependencies();

  await Hive.initFlutter();
  Hive.registerAdapter(QueryModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
    return MaterialApp.router(
      title: 'Demo EZV App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
    );
  }
}
