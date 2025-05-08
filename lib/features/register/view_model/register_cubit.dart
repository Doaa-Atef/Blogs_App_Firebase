import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitialState());

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;


  register({required String email, required String password, required username})async{
    emit(RegisterLoadingState());

    try{
      final user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      print("user =====> {${user}");

     final result= await saveUserDataToFireStore(username: username);
     if(result){
       emit(RegisterSuccessState());

     }
    } on FirebaseAuthException catch(e){
      print(e.message);
      print(e.credential);
      emit(RegisterErrorState(e.message));

    }
  }


  Future<bool> saveUserDataToFireStore({required String username}) async{
    print("saveUserDataToFireStore ${auth.currentUser!.uid}");
    try{
      await firebaseFirestore.collection("users").doc(auth.currentUser!.uid).set({
        "userid":auth.currentUser!.uid,
        "email":auth.currentUser!.email,
        "username": username,
      });
      return true;

    }on FirebaseException catch(e){
      await auth.currentUser!.delete();
      print("Errroorrr ===> $e");
      emit(RegisterErrorState(e.toString()));
      return false;
    }
       
    
    
  }
}
