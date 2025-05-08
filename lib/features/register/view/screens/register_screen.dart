import 'package:firebase_cli/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/routes.dart';
import '../../model/register_request_model.dart';
import '../../view_model/register_cubit.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppColors.primaryColor),
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text("Register",style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black
        ),

        ),
      ),
        body: BlocListener<RegisterCubit, RegisterState>(
          listener: (context, state) {
            if (state is RegisterSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text("Account created successfully"),
                  backgroundColor: AppColors.primaryColor));
              Navigator.pop(context);
            } else if (state is RegisterErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.red));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(

                child: Column(

                  children: [
                    SizedBox(height: 150),
                    Center(
                      child: Text("Register now, to continue",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      validator: (value) =>
                      value!.isEmpty ? 'Enter your name' : null,
                      decoration: InputDecoration(
                        hintText: "Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(

                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    TextFormField(
                      // validator: (v) {
                      //   if (v!.isEmpty) {
                      //     return "Please enter password";
                      //   }else if (v.length<6){
                      //     return "Password must be at least 6 characters";
                      //   }
                      //   return null;
                      // },
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              _obscurePassword =!_obscurePassword;
                            });
                          },
                              icon: Icon(_obscurePassword?
                              Icons.visibility_off_outlined:
                              Icons.visibility_outlined))
                      ),
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<RegisterCubit, RegisterState>(
                      builder: (context, state) {

                          return state is RegisterLoadingState? Center(child: CircularProgressIndicator()) :

                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 30),
                             child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<RegisterCubit>().register(
                                      username: usernameController.text,
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                      // phone: phoneController.text,
                                    );
                                }
                              },
                              style: ButtonStyle(minimumSize: WidgetStatePropertyAll(
                                Size(double.infinity ,50),
                              ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
                              ),

                              child: Text("Register",style: TextStyle(color: Colors.black),),
                                                       ),
                           );


                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        TextButton(onPressed: (){
                          Navigator.pushNamed(context, Routes.login);
                        }, child: Text("Login",style: TextStyle(color: AppColors.secondaryColor)),
                        )],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
