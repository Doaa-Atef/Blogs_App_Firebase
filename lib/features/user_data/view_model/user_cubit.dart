import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../model/user_data_model.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  UserModel? userModel;

  void getUserData() async {
    emit(UserLoading());

    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (doc.exists) {
        emit(UserSuccess(
          userId: uid,
          username: doc['username'],
          email: doc['email'],
        ));
      } else {
        emit(UserError("User data not found."));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}




