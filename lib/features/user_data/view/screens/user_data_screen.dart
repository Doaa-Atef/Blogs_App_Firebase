import 'package:firebase_cli/core/caches/prefs_keys.dart';
import 'package:firebase_cli/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/caches/shared_prefs.dart';
import '../../../../core/routes/routes.dart';
import '../../../login/view/screen/login_screen.dart';
import '../../../login/view_model/login_cubit.dart';
import '../../view_model/user_cubit.dart';

class UserDataScreen extends StatelessWidget {
  const UserDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          title:  Text("Profile", style: TextStyle(color: Colors.black,
          fontWeight: FontWeight.w700)),
          centerTitle: true,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return  Center(child: CircularProgressIndicator());
            } else if (state is UserSuccess) {
              return Padding(
                padding:  EdgeInsets.all(16.0),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child:  Icon(Icons.person, size: 50) ,
                      ),
                      SizedBox(height: 20,),
                      Text("Name: ${state.username}",
                          style: TextStyle(fontSize: 16)),
                       SizedBox(height: 12),
                      Text("Email: ${state.email}",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 12),

                      Text("User ID: ${state.userId}",
                          style: TextStyle(fontSize: 16)),
                      Spacer(),
                      InkWell(
                        onTap: () async {
                          AppSharedPrefs.remove( key: SharedPrefsKeys.userId);
                          Navigator.pushNamed(context, Routes.login);
                        },
                        child: ListTile(
                          leading: Icon(Icons.login_outlined),
                          title: Text("LogOut"),
                        ),
                      )
                    ],

                  ),
                ),
              );
            } else if (state is UserError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

