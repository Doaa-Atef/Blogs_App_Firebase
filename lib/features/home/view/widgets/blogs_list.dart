import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/home_cubit.dart';
import 'blog_item.dart';

class BlogsList extends StatefulWidget {
  const BlogsList({super.key});

  @override
  State<BlogsList> createState() => _BlogsListState();
}

class _BlogsListState extends State<BlogsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen:  (previous,current) => current is GetBlogsSuccess,
      builder: (context, state) {
        if(state is GetBlogsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(state is GetBlogsSuccess){
          if(context.read<HomeCubit>().blogsList.isEmpty){
            return const Center(
              child: Text("No Blogs"),
            );
          }else{
            return ListView.separated(
              shrinkWrap: true,
              itemCount: context.read<HomeCubit>().blogsList.length,
              itemBuilder: (BuildContext context, int index) {
                return BlogItem(blogModel: context.read<HomeCubit>().blogsList[index],
                  onDelete: () {
                    context.read<HomeCubit>().deleteBlog(id: context.read<HomeCubit>().blogsList[index].id,);
                    setState(() {
                      context.read<HomeCubit>().blogsList.removeAt(index);
                    });


                  },);
              }, separatorBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                child: const Divider(
                  thickness: 2,
                  color: Colors.grey,

                ),
              );
            },

            );

          }
        }else if(state is GetBlogsFailure){
          return Center(
            child: Text(state.error),
          );
        }else{
          return SizedBox();
        }


      },
    );
  }
}
