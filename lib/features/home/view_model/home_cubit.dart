import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/home_blog_model.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  late List<HomeBlogModel> blogsList = [];

  getBlogs() async {
    emit(GetBlogsLoading());
    try {

      final result = await fireStore.collection("blogs").get();
      if (kDebugMode) {
        print("result => ${result.docs}");
      }
      blogsList.clear();
      for (var doc in result.docs) {
        if (kDebugMode) {
          print("doc ====> ${doc.data()}");
        }
        blogsList.add(HomeBlogModel.fromJson(doc.data()));
      }
      emit(GetBlogsSuccess());
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("error from firestore => ${e.message}");
      }
      emit(GetBlogsFailure(e.toString()));
    }
  }

  deleteBlog({required String id, }) async {
    emit(DeleteBlogLoading());
    try {
      await fireStore.collection("blogs").doc(id).delete();
      emit(DeleteBlogSuccess());
    } on FirebaseException catch (e) {
      emit(DeleteBlogFailure(e.toString()));
    }
  }
}
