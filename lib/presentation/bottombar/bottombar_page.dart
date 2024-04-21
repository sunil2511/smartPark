import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/history/history_page.dart';
import 'package:flutter_crud/presentation/home/home_page.dart';
import 'package:flutter_crud/presentation/profile/profile_page.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomBarPage extends StatefulWidget {
  const BottomBarPage({super.key});

  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;

  final List<Widget> lstScreens = [
    const HomePage(),
    const HistoryPage(),
     ProfilePage(),
  ];
  @override
  void initState() {
    super.initState();
  }

  indexChange(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        onTap: indexChange,

        // elevation: 0,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.primaryColor2,
        unselectedItemColor: AppColors.primaryColor3,
        selectedLabelStyle: GoogleFonts.sofiaSans(
          textStyle: const TextStyle(
            color: AppColors.primaryColor2,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 14.0,
          ),
        ),

        unselectedLabelStyle: GoogleFonts.sofiaSans(
          textStyle: const TextStyle(
            color: AppColors.primaryColor3,
            fontWeight: FontWeight.w600,
            fontStyle: FontStyle.normal,
            fontSize: 14.0,
          ),
        ),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: SizedBox(
              height: 25,
              width: 25,
              child: Icon(
                Icons.home,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: SizedBox(
                height: 25,
                width: 25,
                child: Icon(
                  Icons.history_edu_outlined,
                ),
              ),
              label: 'History'),
          BottomNavigationBarItem(
            icon: SizedBox(
                height: 25,
                width: 25,
                child: Icon(
                  Icons.person_3_rounded,
                )),
            label: 'Profile',
          ),
        ],
      ),
      body: lstScreens[currentIndex],
    );
  }
}
