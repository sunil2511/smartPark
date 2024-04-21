import 'package:flutter/material.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
              children: [
                TextSpan(
                  text: 'Welcome to ',
                ),
                TextSpan(
                  text: 'SmartPark',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ', your trusted companion in finding convenient parking solutions tailored to your needs. Our mission is to simplify your parking experience, saving you time and hassle while providing you with peace of mind.\n\n',
                ),
                TextSpan(
                  text: 'Our Vision\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'We envision a world where finding parking is effortless and stress-free. Our goal is to revolutionize the way people navigate urban environments by offering intuitive solutions that optimize parking availability and enhance mobility.\n\n',
                ),
                TextSpan(
                  text: 'Who We Are\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'At ',
                ),
                TextSpan(
                  text: 'SmartPark',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: ', we are a passionate team of developers, designers, and urban enthusiasts dedicated to improving urban living through innovative technology. We understand the challenges of parking in crowded cities and aim to address them head-on with our user-centric approach.\n\n',
                ),
                TextSpan(
                  text: 'What We Offer\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Efficiency: Our app provides real-time information on available parking spots, helping you find the nearest and most convenient place to park your vehicle.\n\n',
                ),
                TextSpan(
                  text: 'Convenience: With our intuitive interface and advanced features, such as pre-booking and digital payments, parking has never been easier.\n\n',
                ),
                TextSpan(
                  text: 'Reliability: We partner with trusted parking providers to ensure that our users have access to safe and secure parking facilities wherever they go.\n\n',
                ),
                TextSpan(
                  text: 'Community: Join our growing community of users who share tips, reviews, and insights to help each other navigate the urban landscape.\n\n',
                ),
                TextSpan(
                  text: 'Our Commitment\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'User Privacy: We prioritize the security and privacy of our users\' data, adhering to strict standards to protect their personal information.\n\n',
                ),
                TextSpan(
                  text: 'Continuous Improvement: We are constantly evolving our app based on user feedback and market trends to provide the best possible parking experience.\n\n',
                ),
                TextSpan(
                  text: 'Sustainability: We strive to promote sustainable transportation solutions and reduce the environmental impact of driving by encouraging shared mobility and alternative modes of transport.\n\n',
                ),
                TextSpan(
                  text: 'Get in Touch\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'We\'d love to hear from you! Whether you have questions, suggestions, or just want to say hello, don\'t hesitate to reach out to us. Together, let\'s make parking hassle-free and enjoyable for everyone.\n\n',
                ),
                TextSpan(
                  text: 'Contact Us: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'ezsmartpark02@gmail.com',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}