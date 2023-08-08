import 'package:demo_ezv_app/features/chat/data/datasources/hive/query_model.dart';
import 'package:demo_ezv_app/features/products/data/datasources/hive/query_model.dart';
import 'package:demo_ezv_app/injection.dart';
import 'package:demo_ezv_app/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  configureDependencies();

  await Hive.initFlutter();
  Hive.registerAdapter(QueryModelAdapter());
  Hive.registerAdapter(ChatModelAdapter());
  Hive.registerAdapter(RoomChatModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Demo EZV App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
