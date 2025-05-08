import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../model/home_blog_model.dart';
import '../../view_model/home_cubit.dart';
import '../widgets/blogs_list.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getBlogs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result =
          await Navigator.pushNamed(context, Routes.addBlog);
          context.read<HomeCubit>().getBlogs();
          if (kDebugMode) {
            print("result => $result");
          }
          if (result is HomeBlogModel) {
            if (kDebugMode) {
              print(result.id);
            }
            if (kDebugMode) {
              print(result.uid);
            }
            if (kDebugMode) {
              print(result.title);
            }
            if (kDebugMode) {
              print(result.description);
            }
            if (kDebugMode) {
              print(result.date);
            }
            if (kDebugMode) {
              print(result.image);
            }
            setState(() {
              context.read<HomeCubit>().blogsList.add(result);
            });
          }
        },
        child: Icon(Icons.add),
      ),
      body: BlogsList(),

    );
  }
}
