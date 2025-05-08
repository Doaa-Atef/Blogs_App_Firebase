import 'package:firebase_cli/features/splash/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';

import 'core/routes/routes_services.dart';
import 'core/styles/app_colors.dart';
import 'main.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor:AppColors.primaryColor),
      ),
     debugShowCheckedModeBanner: false,
      onGenerateRoute: RoutesServices.generateRoute,
    );
  }
}