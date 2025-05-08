import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../../core/caches/prefs_keys.dart';
import '../../../core/caches/shared_prefs.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  void login(String email, String password) async {
    emit(LoginLoading());
    try{
      final user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      if(user != null){
        await saveUserDataToLocal(email: email, userId: user.user!.uid);

        emit(LoginSuccess());
      }
    } on FirebaseAuthException catch(e){
      emit(LoginError(e.code.toString()));
    }
  }

  Future<Map<String, dynamic>?> getUserDataFromFireStore() async {
    try {
      final doc = await firebaseFirestore.collection("users").doc(auth.currentUser!.uid).get();
      return doc.data();
    } on FirebaseException catch (e) {
      print("error from firestore => ${e.message}");
      emit(LoginError(e.message ?? "Unknown error"));
      return null;
    }
  }



  saveUserDataToLocal({required String email, required String userId}) async {
    AppSharedPrefs.setString(key: SharedPrefsKeys.email, value: email);
    AppSharedPrefs.setString(key: SharedPrefsKeys.userId, value: userId);

  }

}
