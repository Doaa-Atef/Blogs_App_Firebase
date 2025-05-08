import 'package:flutter/material.dart';

import 'blog_item.dart';

class BlogsList extends StatelessWidget {
  const BlogsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,

        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return BlogItem();
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

      ),
    );
  }
}
