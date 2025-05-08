import 'package:flutter/material.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: double.infinity,
      decoration:BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
            color: Colors.grey.shade300
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              child: Image.network("https://firebasestorage.googleapis.com/v0/b/bekya-9038f.appspot.com/o/uploads%2FGoKqDNhZVrVAUYSagEj0xEqbaZb2%2F1746040221295.png?alt=media&token=c37e6416-82c8-46b8-8143-1d0e25073a7f",
                width: double.infinity,
                fit: BoxFit.fill,
                height: 200,)),
          Padding(
            padding:  EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("Title",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Text("25-5-2025"),

                  ],
                ),
                Divider(),
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                  maxLines: 3,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade700
                  ),
                ),
              ],
            ),
          ),

        ],
      ),

    );
  }
}
