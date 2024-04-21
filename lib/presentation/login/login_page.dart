import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/data/controller/login_controller.dart';
import 'package:flutter_crud/presentation/register/register_page.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/widgets/auto_size_text.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends GetView {
  LoginPage({super.key});

  @override
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor2,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.primaryColor3,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Obx(
        () => (controller.isLoading.value == false)
            ? SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/auth_header.jpg",
                          width: screenWidth(context),
                          fit: BoxFit.contain,
                        ),
                        Image.asset(
                          "assets/images/smart_park_logo.jpg",
                          width: screenWidth(context),
                          height: screenHeight(context) * 0.27,
                          fit: BoxFit.contain,
                        ),
                        
                        const AutoSizeTextWidget(
                          text: "Email",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor3,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          onChanged: (value) => controller.setEmail(value),
                          controller: controller.emailController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 8.0,
                              horizontal: 8.0,
                            ),
                            errorText:
                                controller.emailErrorText.value.toString(),
                            errorStyle:
                                context.theme.inputDecorationTheme.errorStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color: controller.emailErrorText.value.isEmpty
                                    ? const Color(0xffcccccc)
                                    : AppColors.redColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        const AutoSizeTextWidget(
                          text: "Password",
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.primaryColor3,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(
                          height: 8.0,
                        ),
                        TextField(
                          onChanged: (value) => controller.setPassword(value),
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8.0,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.isPasswordVisibleSet();
                              },
                              icon: Icon(
                                controller.isVisible.value == false
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: AppColors.primaryColor3,
                              ),
                            ),
                            errorText:
                                controller.passwordErrorText.value.toString(),
                            errorStyle:
                                context.theme.inputDecorationTheme.errorStyle,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                                color:
                                    controller.passwordErrorText.value.isEmpty
                                        ? const Color(0xffcccccc)
                                        : AppColors.redColor,
                              ),
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                            ),
                          ),
                          obscureText: controller.isVisible.value,
                        ),
                        const SizedBox(height: 16.0),
                        GestureDetector(
                            onTap: () {
                              Get.to(
                                const RegisterPage(),
                              );
                            },
                            child: Text(
                              "Don't have account ? .Register",
                              style: GoogleFonts.sofiaSans(
                                textStyle: const TextStyle(
                                  color: AppColors.primaryColor3,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 20,
                                ),
                              ),
                            )),
                        const SizedBox(
                          height: 10.0,
                        ),
                        CustomAppButton(
                          onTap: () {
                            controller.loginUser();
                          },
                          title: "Login",
                          textStyle: GoogleFonts.sofiaSans(
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
