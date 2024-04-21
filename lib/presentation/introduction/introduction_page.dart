import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/introduction_dashboard/introducation_dashboard_screen.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/widgets/auto_size_text.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            "assets/images/introduction1.jpg",
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const AutoSizeTextWidget(
            maxLines: 3,
            text: "Book A Parking",
            style: TextStyle(
              color: AppColors.primaryColor2,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Center(
              child: AutoSizeTextWidget(
                maxLines: 3,
                text: "Going some where? Book a parking.",
                style: TextStyle(
                  color: AppColors.primaryColor3,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            "assets/images/introduction_final_2.png",
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const AutoSizeTextWidget(
            maxLines: 3,
            text: "Offer On Parking",
            style: TextStyle(
              color: AppColors.primaryColor2,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Center(
              child: AutoSizeTextWidget(
                maxLines: 3,
                text: "Driving some where? Get Benefits on parking.",
                style: TextStyle(
                  color: AppColors.primaryColor3,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            "assets/images/introduction3.jpg",
            fit: BoxFit.contain,
          ),
          const SizedBox(
            height: 20.0,
          ),
          const AutoSizeTextWidget(
            maxLines: 3,
            text: "Travel Through Cities",
            style: TextStyle(
              color: AppColors.primaryColor2,
              fontSize: 30,
              fontWeight: FontWeight.w700,
              fontStyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            child: Center(
              child: AutoSizeTextWidget(
                maxLines: 3,
                text: "Search a best parking for your journey..",
                style: TextStyle(
                  color: AppColors.primaryColor3,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomAppButton(
          onTap: () {
            if (_currentPageIndex == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const IntroductionDashBoardScreen(),
                ),
              );
            } else {
              _pageController.animateToPage(
                _currentPageIndex + 1,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            }
          },
          title: "NEXT",
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        children: _pages,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
