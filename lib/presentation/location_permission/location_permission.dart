import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/bottombar/bottombar_page.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPermissionScreen extends StatefulWidget {
  const LocationPermissionScreen({super.key});

  @override
  State<LocationPermissionScreen> createState() => _LocationPermissionState();
}

class _LocationPermissionState extends State<LocationPermissionScreen> {
  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();

  @override
  void initState() {
    super.initState();
  }

  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isDenied) {
      // Handle denied permission
    } else if (status.isGranted) {
      // Permission granted
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.latitude);
    print(position.longitude);

    customSharedPreferences.setDoubleValue('lat', position.latitude);
    customSharedPreferences.setDoubleValue('long', position.latitude);
    Fluttertoast.showToast(msg: "Location Enabled Successfully");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomBarPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomAppButton(
                onTap: () => requestLocationPermission(),
                title: "Enable Location",
                textStyle: GoogleFonts.sofiaSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              CustomAppButton(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomBarPage(),
                    ),
                  );
                },
                title: "Not Now",
                textStyle: GoogleFonts.sofiaSans(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Container(
          width: screenWidth(context),
          height: screenHeight(context),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/images/Splash Screen UI.jpg",
                ),
                fit: BoxFit.fill),
          ),
        ));
  }
}
