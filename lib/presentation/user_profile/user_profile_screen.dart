import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();

  String firstName = "";
  String lastName = "";
  String gender = "";
  String number = "";
  String state = "";
  String email = "";
  bool isLoading = false;
  List<Map<String, dynamic>> documents = [];
  fetchUser() async {
    String? uId = customSharedPreferences.getStringValue(
      'userId',
    );

    try {
      setState(() {
        isLoading = true;
      });
      var docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();

      Map<String, dynamic>? data = docSnapshot.data();
      setState(() {
        firstName = data!['firstName'];
        lastName = data['lastName'];
        gender = data['gender'];
        number = data['number'];
        state = data['province'];
        email = data['email'];
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    fetchUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
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
        child: (isLoading == false)
            ? Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        'First Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(firstName),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Last Name:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(lastName),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Gender:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(gender),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Province:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(state),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Email:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(email),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Number:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                          width:
                              8), // Adjust the spacing between text and value
                      Text(number),
                    ],
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
