import 'package:flutter/material.dart';

import '../../../../core/routes/routes.dart';
import '../widgets/blogs_list.dart';
import '../widgets/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, Routes.addBlog);
        },
        child: Icon(Icons.add),

      ),
      body: Column(
        children: [
          BlogsList(),
        ],
      ),
    );
  }
}
