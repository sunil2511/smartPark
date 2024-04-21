import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/order_list/order_list_screen.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.15,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/home_banner.jpg",
                    ),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Parking Services',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderListScreen()));
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(
                  "assets/images/parking_icon.jpg",
                  width: 50,
                  height: 50,
                ),
                const Text(
                  'Parkings',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.40,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage(
                      "assets/images/kuvai_map.jpg",
                    ),
                    fit: BoxFit.fill),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
