import 'package:firebase_cli/core/routes/routes.dart';
import 'package:firebase_cli/features/home/view/screens/home_screen.dart';
import 'package:firebase_cli/features/home/view_model/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/add_blog/view/screens/add_blog_screen.dart';
import '../../features/login/view/screen/login_screen.dart';
import '../../features/register/view/screens/register_screen.dart';
import '../../features/splash/view/screens/splash_screen.dart';


class RoutesServices {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("name ===> ${settings.name}");
    print("arguments ===> ${settings.arguments}");
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });

      case Routes.login:
        return MaterialPageRoute(builder: (context) {
          return LoginScreen();
        });
      case Routes.register:
        return MaterialPageRoute(builder: (context) {
          return RegisterScreen();
        });
      case Routes.home:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider(
            create: (context) => HomeCubit(),
            child: HomeScreen(),
          );
        });
      case Routes.addBlog:
        return MaterialPageRoute(builder: (context) {
          return AddBlogScreen();
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(
              child: Text("Not Found"),
            ),
          );
        });
    }
  }
}