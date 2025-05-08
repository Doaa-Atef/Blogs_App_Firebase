import 'dart:io';

import 'package:firebase_cli/core/caches/prefs_keys.dart';
import 'package:firebase_cli/core/caches/shared_prefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../core/styles/app_colors.dart';
import '../../model/blog_model.dart';
import '../../view_model/add_blog_cubit.dart';

class AddBlogForm extends StatefulWidget {
  const AddBlogForm({super.key});

  @override
  State<AddBlogForm> createState() => _AddBlogFormState();
}

class _AddBlogFormState extends State<AddBlogForm> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<void> pickDate({required BuildContext context}) async {
    DateTime? date = await showDatePicker(
        context: context, firstDate: DateTime(2020), lastDate: DateTime(2040));
    if (kDebugMode) {
      print(date);
    }
    if (date != null) {
      String dateFormat = DateFormat('yyyy-MM-dd').format(date);
      dateController.text = dateFormat;
    }
  }

  XFile? image = XFile("");


  pickImage({required ImageSource source}) async {
    final ImagePicker picker = ImagePicker();
    image = await picker.pickImage(source: source);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              validator: (v) {
                if (v!.isEmpty) {
                  return "Please enter title";
                }
                return null;
              },
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              minLines: 5,
              maxLines: 20,
              validator: (v) {
                if (v!.isEmpty) {
                  return "Please enter description";
                }
                return null;
              },
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: "description",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              readOnly: true,
              onTap: () async {
                if (kDebugMode) {
                  print("tapped");
                }
                pickDate(context: context);
              },
              controller: dateController,
              validator: (v) {
                if (v!.isEmpty) {
                  return "Please enter date";
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Date",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            SizedBox(
              height: 15,
            ),
            image!.path.isEmpty ?
            Container() :
            Image.file(File(image!.path,
            ),
              height: 100,
              width: 150,
            ),

            TextButton(
              onPressed:(){
                showCupertinoDialog(context: context,
                  builder: (BuildContext context) {

                    return CupertinoAlertDialog(
                      title: Text("Pick Image"),
                      actions: [
                        CupertinoDialogAction(child: Text("Camera"),
                          onPressed: (){
                            pickImage(source: ImageSource.camera);
                          },
                        ),
                        CupertinoDialogAction(child: Text("Gallery"),
                          onPressed: (){
                            pickImage(source: ImageSource.gallery);
                          },
                        ),
                        CupertinoDialogAction(child: Text("Cancel",
                          style: TextStyle(
                              color: Colors.red
                          ),
                        ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        ),

                      ],
                    );
                  },

                );
              },
              child: Text("Pick Image"),

            ),
            SizedBox(
              height: 15,
            ),
            BlocBuilder<AddBlogCubit, AddBlogState>(
              builder: (context, state) {
                return state is AddBlogLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AddBlogCubit>().addBlog(
                          blogModel: BlogModel(
                              uid: AppSharedPrefs.getString(
                                  key: SharedPrefsKeys.userId),
                              image: image!.path,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text), image:  File(image!.path));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  child: Text("Add"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
