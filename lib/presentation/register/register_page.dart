import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/presentation/bottombar/bottombar_page.dart';
import 'package:flutter_crud/presentation/data/order_service.dart';
import 'package:flutter_crud/presentation/location_permission/location_permission.dart';
import 'package:flutter_crud/presentation/login/login_page.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';
import 'package:flutter_crud/widgets/auto_size_text.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController numberController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();

  String numberError = "";
  String firstNameError = "";
  String lastNameError = "";
  String emailError = "";
  String cityError = "";
  String pinError = "";
  String genderError = "";
  String stateError = "";
  String passwordError = "";
  bool isVisible = true;

  bool isLoading = false;
  var _dropDownValue;
  var _selectGender;

  static final _stateList = [
    "Select Province",
    'AL Ahmadi',
    'AL Farwaniyah',
    'AL Jahra',
    'Capital Governorate(AI Asimah)',
    'Hawalli',
    'Mubarak AL-Kabeer',
  ];

  static final _genderList = [
    'Select Gender',
    'Male',
    'Female',
  ];

  @override
  void initState() {
    super.initState();
  }

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomAppButton(
          onTap: () async {
            try {
              setState(() {
                isLoading = true;
              });
              if (numberController.text.isNotEmpty &&
                  numberController.text.length == 8 &&
                  firstNameController.text.isNotEmpty &&
                  lastNameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty &&
                  cityController.text.isNotEmpty &&
                  pinController.text.isNotEmpty &&
                  stateError.isEmpty &&
                  genderError.isEmpty) {
                final UserCredential userCredential =
                    await auth.createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                Map<String, dynamic> data = {
                  'firstName': firstNameController.text ?? "",
                  'lastName': lastNameController.text,
                  'number': numberController.text ?? "",
                  'email': emailController.text ?? "",
                  'streetName': cityController.text ?? "",
                  'blockNumber': pinController.text ?? "",
                  'province': _dropDownValue ?? "",
                  'gender': _selectGender ?? "",
                  'uId': userCredential.user!.uid.toString() ?? "",
                };

                if (userCredential.user!.uid.isNotEmpty) {
                  OrderService().registerUser(
                    user: data,
                    userId: userCredential.user!.uid,
                  );
                  customSharedPreferences.setStringValue(
                      'email', userCredential.user!.email.toString());
                  customSharedPreferences.setStringValue(
                      'name', userCredential.user!.displayName.toString());
                  customSharedPreferences.setStringValue(
                      'userId', userCredential.user!.uid.toString());
                  customSharedPreferences.setStoreSession('userSession', true);
                  setState(() {
                    isLoading = false;
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LocationPermissionScreen(),
                    ),
                  );
                } else {
                  setState(() {
                    isLoading = false;
                  });
                }
              } else {
                setState(() {
                  isLoading = false;
                });
              }
              if (numberController.text.isEmpty) {
                numberError = "Please Enter Mobile Number";
              } else if (numberController.text.isNotEmpty &&
                  numberController.text.length < 8) {
                numberError = "Invalid Phone Number";
              } else {
                numberError = "";
              }
              if (firstNameController.text.isEmpty) {
                firstNameError = "Please Enter first name";
              } else {
                firstNameError = "";
              }
              if (lastNameController.text.isEmpty) {
                lastNameError = "Please Enter last name";
              } else {
                lastNameError = "";
              }
              if (emailController.text.isEmpty) {
                emailError = "Please Enter email";
              } else {
                emailError = "";
              }
              if (pinController.text.isEmpty) {
                pinError = "Please Enter block number";
              } else {
                pinError = "";
              }
              if (cityController.text.isEmpty) {
                cityError = "Please Enter street name";
              } else {
                cityError = "";
              }
              if (_dropDownValue == "Select province" || _dropDownValue == null) {
                stateError = "Please Select province";
              } else {
                stateError = "";
              }
              if (_selectGender == "Select Gender" || _selectGender == null) {
                genderError = "Please Select gender";
              } else {
                genderError = "";
              }
              if (passwordController.text.isEmpty) {
                passwordError = "Please Enter password";
              } else {
                passwordError = "";
              }
              
            } on FirebaseAuthException catch (e) {
              setState(() {
                isLoading = false;
              });
              Fluttertoast.showToast(msg: e.code.toString());
            }
          },
          title: "Register",
          textStyle: GoogleFonts.sofiaSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: isLoading == false
            ? Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        text: "First Name",
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
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: const [
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        controller: firstNameController,
                        onChanged: (value) {
                          setState(() {
                            firstNameController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter First Name",
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
                          errorText: firstNameError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: firstNameError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const AutoSizeTextWidget(
                        text: "Last Name",
                        style: TextStyle(
                          color: AppColors.primaryColor3,
                          fontSize: 18,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: const [
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        controller: lastNameController,
                        onChanged: (value) {
                          setState(() {
                            lastNameController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Last Name",
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
                          errorText: lastNameError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: lastNameError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const AutoSizeTextWidget(
                        text: "Mobile Number",
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
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(8),
                        ],
                        controller: numberController,
                        onChanged: (value) {
                          setState(() {
                            numberController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Mobile Number",
                          prefixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '+965',
                                style: GoogleFonts.sofiaSans(
                                  textStyle: const TextStyle(
                                    color: AppColors.primaryColor3,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                          errorText: numberError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: numberError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
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
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        inputFormatters: const [
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        controller: emailController,
                        onChanged: (value) {
                          setState(() {
                            emailController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Email",
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
                          errorText: emailError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: emailError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const AutoSizeTextWidget(
                        text: "Gender",
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
                      SizedBox(
                        height: screenHeight(context) * 0.07,
                        child: DropdownButtonFormField(
                          isDense: true,
                          itemHeight: 48,
                          iconSize: 28,
                          hint: _selectGender == null
                              ? const Text('Select Gender',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                  ))
                              : Text(
                                  _selectGender,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          items: _genderList.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _selectGender = val;
                              },
                            );
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ),
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(
                                  0xffcccccc,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        genderError,
                        style: const TextStyle(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AutoSizeTextWidget(
                        text: "Province",
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
                      SizedBox(
                        height: screenHeight(context) * 0.07,
                        child: DropdownButtonFormField(
                          isDense: true,
                          itemHeight: 48,
                          iconSize: 28,
                          hint: _dropDownValue == null
                              ? const Text('Select Province',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                  ))
                              : Text(
                                  _dropDownValue,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                          isExpanded: true,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14),
                          items: _stateList.map(
                            (val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          onChanged: (val) {
                            setState(
                              () {
                                _dropDownValue = val;
                              },
                            );
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                            ),
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
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: const BorderSide(
                                style: BorderStyle.solid,
                                color: Color(0xffcccccc),
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color(
                                  0xffcccccc,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        stateError,
                        style: const TextStyle(
                          color: AppColors.redColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const AutoSizeTextWidget(
                        text: "Block Number",
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
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(6),
                        ],
                        controller: pinController,
                        onChanged: (value) {
                          setState(() {
                            pinController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Block Number",
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
                          errorText: pinError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: pinError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const AutoSizeTextWidget(
                        text: "Street Name",
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
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: const [
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        controller: cityController,
                        onChanged: (value) {
                          setState(() {
                            cityController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Street Name",
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
                          errorText: cityError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: cityError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
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
                        obscureText: isVisible,
                        style: GoogleFonts.sofiaSans(
                          textStyle: const TextStyle(
                            color: AppColors.primaryColor3,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        inputFormatters: const [
                          // LengthLimitingTextInputFormatter(10),
                        ],
                        controller: passwordController,
                        onChanged: (value) {
                          setState(() {
                            passwordController.text = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: Icon(
                              isVisible == false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primaryColor3,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 8.0,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Enter Password",
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
                          errorText: passwordError,
                          errorStyle: const TextStyle(
                            color: AppColors.redColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              style: BorderStyle.solid,
                              color: passwordError.isEmpty
                                  ? const Color(0xffcccccc)
                                  : AppColors.redColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              8.0,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Center(
                          child: Text(
                            "Already have account? Login",
                            style: GoogleFonts.sofiaSans(
                              textStyle: const TextStyle(
                                color: AppColors.primaryColor3,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 90,
                      )
                    ],
                  ),
                ),
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
