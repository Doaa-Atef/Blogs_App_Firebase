import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/styles/app_colors.dart';
import '../../view_model/add_blog_cubit.dart';
import '../widgets/add_blog_form.dart';

class AddBlogScreen extends StatelessWidget {
  const AddBlogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddBlogCubit(),
      child: BlocListener<AddBlogCubit, AddBlogState>(
        listener: (context, state) {
          if (state is AddBlogSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Blog Added",
              style: TextStyle(
                  color: Colors.black
              ),
            ),
              backgroundColor: AppColors.primaryColor,
            ));
            Navigator.pop(context);
          }

        },
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Column(
              children: [
                AddBlogForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
