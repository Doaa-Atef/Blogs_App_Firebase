import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_cli/core/caches/prefs_keys.dart';
import 'package:firebase_cli/core/caches/shared_prefs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/blog_model.dart';
part 'add_blog_state.dart';

class AddBlogCubit extends Cubit<AddBlogState> {
  AddBlogCubit() : super(AddBlogInitial());
  FirebaseFirestore firebaseFireStore = FirebaseFirestore.instance;
  FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  addBlog({required AddBlogModel blogModel, required File image}) async {
    emit(AddBlogLoading());
    try{
      if(image.path.isNotEmpty){
        final imageUrl = await uploadImageToFireStorage(image: image);
        blogModel.image = imageUrl;
      }

      await firebaseFireStore.collection("blogs").doc(blogModel.id).set(blogModel.toJson());

      if (kDebugMode) {
        print("blog added");
      }
      emit(AddBlogSuccess(blogModel));
    } on FirebaseException catch (e){
      if (kDebugMode) {
        print(e);
      }
      emit(AddBlogError(e.message.toString()));

    }
  }

  uploadImageToFireStorage({required File image}) async {
    try{
      final reference =firebaseStorage.ref("uploads/${AppSharedPrefs.getString(key: SharedPrefsKeys.userId)}/${DateTime.now().millisecondsSinceEpoch}.png");
      final uploadImage = await reference.putFile(image);
      if (kDebugMode) {
        print("uploadImage ===> $uploadImage");
      }
      final imageUrl = await reference.getDownloadURL();
      if (kDebugMode) {
        print("imageUrl ===> $imageUrl");
      }
      return imageUrl;
    } on FirebaseException catch (e){
      if (kDebugMode) {
        print("firebaseException ===> $e");
      }
      emit(AddBlogError(e.message.toString()));
    }

  }
}
