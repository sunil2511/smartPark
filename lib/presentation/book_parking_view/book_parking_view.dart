import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';

class BookParkingView extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>>? data;
  const BookParkingView({super.key,this.data,});

  @override
  State<BookParkingView> createState() => _BookParkingViewState();
}

class _BookParkingViewState extends State<BookParkingView> {
  final List<bool> _selectedSeats = List.generate(30, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parking List"),
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
      body: SizedBox(
        width: screenWidth(context),
        // height: screenHeight(context) * 0.80,
        child: GridView.builder(
          itemCount: widget.data!.length,
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedSeats[index] = !_selectedSeats[index];
                });
              },
              child: Container(
                margin: const EdgeInsets.all(5),
                color: _selectedSeats[index]
                    ? Colors.grey
                    : AppColors.primaryColor,
                child: Center(
                  child: Text(
                    'Seat ${index + 1}',
                    style: TextStyle(
                      color:
                          _selectedSeats[index] ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
