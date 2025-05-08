import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cli/core/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/routes/routes.dart';
import '../../view_model/login_cubit.dart';

class LoginScreen extends StatefulWidget {
   const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
  create: (context) => LoginCubit(),
  child: BlocListener<LoginCubit, LoginState>(
  listener: (context, state) async {
    if(state is LoginSuccess){
      Navigator.pushNamed(context, Routes.home);
    }else if(state is LoginError){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
    }
  },
  child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text("Login",style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
          color: Colors.black
          ),

          ),
        ),
        body:
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(height: 150,),
                  Center(
                    child: Text("Login now, to continue",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "please enter email";
                      }
                      else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(v)) {
                        return "Please enter a valid email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please enter password";
                      }else if (v.length<6){
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
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
                  Container(
                    alignment: Alignment.centerRight,
                    child: TextButton(onPressed: () {},
                      child: Text("Forget Password?", style:
                      TextStyle(color: AppColors.secondaryColor),
                      ),
                    ),
                  ),

                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return state is LoginLoading ? CircularProgressIndicator() : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().login(emailController.text, passwordController.text);
                            }
                          },
                          style: ButtonStyle(
                            minimumSize: WidgetStatePropertyAll(
                              Size(double.infinity, 50),
                            ),
                            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
                          ),
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      );
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.register);


                          },
                          child: Text(
                            "Register",
                            style: TextStyle(color: AppColors.secondaryColor),
                          )
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),),
),
);
  }
}
