import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/login/login_page.dart';
import 'package:flutter_crud/presentation/register/register_page.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/widgets/auto_size_text.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';

class IntroductionDashBoardScreen extends StatefulWidget {
  const IntroductionDashBoardScreen({super.key});

  @override
  State<IntroductionDashBoardScreen> createState() =>
      _IntroductionDashBoardScreenState();
}

class _IntroductionDashBoardScreenState
    extends State<IntroductionDashBoardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatButtons(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                    "assets/images/introducation_final_3.jpg",
                    width: screenWidth(context),
                    height: screenHeight(context) * 0.40,
                    fit: BoxFit.cover,
                  ),
              ),
                const SizedBox(
                  height: 20.0,
                ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 8.0,
                  bottom: 8.0,
                  left: 20.0,
                  right: 20.0,
                ),
                child: AutoSizeTextWidget(
                  maxLines: 3,
                  text: "Choose your way of traveling",
                  style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 3.0,
                  bottom: 8.0,
                ),
                child: AutoSizeTextWidget(
                  maxLines: 7,
                  text:
                      "Parallel parking is when all the cars are neatly lined up in rows, except yours.The way you park your car is the way you park your life.",
                  style: TextStyle(
                    color: AppColors.primaryColor2,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

floatButtons(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomAppButton(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  LoginPage(),
              ),
            );
          },
          title: "LOGIN",
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomAppButton(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterPage(),
                ),
              );
            },
            title: "SIGN UP",
            buttonColor: AppColors.primaryColor2,
            textStyle: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
            )),
      )
    ],
  );
}
