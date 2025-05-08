
import 'dart:async';
import 'package:firebase_cli/core/caches/shared_prefs.dart';
import 'package:flutter/material.dart';
import '../../../../core/caches/prefs_keys.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _textController;
  bool isVisible = false;

  String displayedText = "";
  int currentIndex = 0;
  late Timer _typewriterTimer;

  void showIcon() {
    setState(() {
      isVisible = true;
    });
  }

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    Future.delayed(Duration(milliseconds: 1000), () {
      showIcon();
      _textController.forward().whenComplete(() {
        startTypewriterEffect();
      });
    });
  }

  void startTypewriterEffect() {
    _typewriterTimer = Timer.periodic(Duration(milliseconds: 50), (timer) {
      if (currentIndex < "Save Your Moments".length) {
        setState(() {
          displayedText += "Save Your Moments"[currentIndex];
          currentIndex++;
        });
      } else {
        _typewriterTimer.cancel();
        Future.delayed(Duration(milliseconds: 500),
            (){
          checkLoginStatus();
            });
      }
    });
  }

  checkLoginStatus() async {
    final String userId = AppSharedPrefs.getString(key: SharedPrefsKeys.userId);
    print("email === ${SharedPrefsKeys.userId.name}");
    if (userId.isNotEmpty){
      Navigator.pushReplacementNamed(context, Routes.home);
    }else{
       Navigator.pushReplacementNamed(context, Routes.login);

    }
  }

  @override
  void dispose() {
    _textController.dispose();
    _typewriterTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> letters = "Notes APP".split("");

    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: isVisible ? 1 : 0,
              duration: Duration(milliseconds: 1000),
              child: Icon(
                Icons.note_alt_outlined,
                size: 120,
                color: AppColors.primaryColor,
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(letters.length, (index) {
                final Animation<Offset> slideAnimation = Tween<Offset>(
                  begin: Offset(index.isEven ? -1.5 : 1.5, 0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _textController,
                    curve: Interval(
                      index / letters.length,
                      1.0,
                      curve: Curves.easeOut,
                    ),
                  ),
                );

                final Animation<double> fadeAnimation = Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).animate(
                  CurvedAnimation(
                    parent: _textController,
                    curve: Interval(
                      index / letters.length,
                      1.0,
                      curve: Curves.easeIn,
                    ),
                  ),
                );

                return SlideTransition(
                  position: slideAnimation,
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: Text(
                      letters[index],
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: AppColors.blackTextColor,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: AppColors.primaryColor.withOpacity(0.5),
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              displayedText,
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700
              ),
            ),
          ],
        ),
      ),
    );
  }
}



