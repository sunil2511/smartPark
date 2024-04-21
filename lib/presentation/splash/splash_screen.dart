import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/introduction/introduction_page.dart';
import 'package:flutter_crud/presentation/login/login_page.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();
  @override
  void initState() {
    checkIfIsLogged();
    super.initState();
  }

  void checkIfIsLogged() async {
    Future.delayed(
      const Duration(
        seconds: 3,
      ),
    ).then(
      (val) {
        bool userSession = customSharedPreferences.getStoreSession(
          'userSession',
        );

        if (userSession == true) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const IntroductionPage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: screenWidth(context),
      height: screenHeight(context),
      decoration: const BoxDecoration(
          color: AppColors.primaryColor2,
          image: DecorationImage(
            image: AssetImage(
              "assets/images/Splash Screen UI.jpg",
            ),
            fit: BoxFit.cover,
          )),
    );
  }
}
