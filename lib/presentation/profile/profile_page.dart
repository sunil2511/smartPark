import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/about_us/about_us_page.dart';
import 'package:flutter_crud/presentation/login/login_page.dart';
import 'package:flutter_crud/presentation/user_profile/user_profile_screen.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';

import '../../utils/services/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AboutUsPage(),
                  ),
                );
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.present_to_all_rounded,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "About Us",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserProfileScreen()));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.location_city_rounded,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "My Profile",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                customSharedPreferences.setStoreSession('userSession', false);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.logout,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
