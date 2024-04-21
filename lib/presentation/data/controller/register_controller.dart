import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/order_list/order_list_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  final email = ''.obs;
  final password = ''.obs;
  final emailErrorText = ''.obs;
  final passwordErrorText = ''.obs;

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return 'Enter a valid email';
    }
    return emailErrorText.value = '';
  }

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return passwordErrorText.value = '';
  }

  void setEmail(String value) {
    email.value = value;
    update();
  }

  void setPassword(String value) {
    password.value = value;
    update();
  }

  registerUser() async {
    try {
      isLoading.value = true;
      update();
      if (email.isNotEmpty &&
          password.isNotEmpty &&
          password.value.length >= 6) {
        final UserCredential userCredential =
            await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        update();
        print('User sign in: ${userCredential.user!.uid}');
        if (userCredential.user != null) {
          isLoading.value = false;
          update();
          Get.to(OrderListScreen());
        }
      }
      if (email.isEmpty) {
        emailErrorText.value = "Please Enter Email";
      } else if (email.isNotEmpty && validateEmail(email.value) != true) {
        emailErrorText.value = "Invalid Email";
      } else {
        emailErrorText.value = "";
      }
      if (password.isEmpty) {
        passwordErrorText.value = "Please Enter Password";
      } else if (passwordErrorText.isNotEmpty &&
          validatePassword(password.value) != true) {
        passwordErrorText.value = "Invalid Password";
      } else {
        passwordErrorText.value = "";
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      update();
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: e.code.toString());

        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: e.code.toString());
        print('The account already exists for that email.');
      } else {
        print(e.code);
        Fluttertoast.showToast(msg: e.code.toString());
      }
    }
  }
}
