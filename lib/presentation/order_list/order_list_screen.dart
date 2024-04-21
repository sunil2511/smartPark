import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_crud/presentation/book_parking_view/book_parking_view.dart';
import 'package:flutter_crud/presentation/create_order/create_order_screen.dart';
import 'package:flutter_crud/presentation/data/controller/order_list_controller.dart';
import 'package:flutter_crud/presentation/data/order_service.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';
import 'package:flutter_crud/widgets/custom_elevated_button.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderListScreen extends StatelessWidget {
  const OrderListScreen({super.key});

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
      body: OrderList(),
    );
  }
}

class OrderList extends GetView {
  OrderList({super.key});

  @override
  OrderListController controller = Get.put(OrderListController());
  CustomSharedPreferences customSharedPreferences = CustomSharedPreferences();

  void _openGoogleMaps(double latitude, double longitude) async {
    // Construct the URL with the location parameters
    String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

    // Check if the device supports opening URLs
    if (await canLaunch(googleMapsUrl)) {
      // Open the URL with the default browser
      await launch(googleMapsUrl);
    } else {
      // Show an error message if the URL can't be launched
      throw 'Could not open Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection('parkingLocations').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          QuerySnapshot<Map<String, dynamic>>? lstOrders = snapshot.data;

          return lstOrders!.size == 0
              ? Center(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/no_data_found.jpg",
                        width: screenWidth(context),
                        height: screenHeight(context) * 0.30,
                        fit: BoxFit.contain,
                      ),
                      const Text(
                        "No Data Found.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: lstOrders.size,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  // height: 200,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  lstOrders.docs[index]
                                                      ['provinceName'],
                                                ),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.location_city,
                                                    ),
                                                    Text(
                                                      lstOrders.docs[index]
                                                          ['provinceName'],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient:
                                                        const LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                      colors: [
                                                        Color(0xFFA5D6A7),
                                                        Color(0xFF4CAF50),
                                                      ],
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          lstOrders.docs[index]
                                                                  ['slots']
                                                              .toString(),
                                                        ),
                                                        const Text(
                                                          "Available Spots",
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFEEEEEE),
                                                Color(0xFFBDBDBD),
                                              ],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.money,
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  lstOrders.docs[index]
                                                      ['hourlyRate'],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFEEEEEE),
                                                Color(0xFFBDBDBD),
                                              ],
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.history,
                                                ),
                                                const SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                  lstOrders.docs[index]
                                                          ['timeSlot']
                                                      .toString(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFEEEEEE),
                                                Color(0xFFBDBDBD),
                                              ],
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.camera_indoor_outlined,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                    "This parking structure has license plat recognition"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8.0,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Color(0xFFEEEEEE),
                                                Color(0xFFBDBDBD),
                                              ],
                                            ),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.airplane_ticket_rounded,
                                                ),
                                                SizedBox(
                                                  width: 8.0,
                                                ),
                                                Text(
                                                    "This parking structure has ticket validation"),
                                              ],
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20.0,
                                        ),
                                        CustomAppButton(
                                          onTap: () {
                                            _openGoogleMaps(
                                                double.parse(
                                                    lstOrders.docs[index]
                                                        ['provinceLat']),
                                                double.parse(
                                                    lstOrders.docs[index]
                                                        ['provinceLong']));
                                          },
                                          title: "Navigate",
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
                                          height: 15.0,
                                        ),
                                        CustomAppButton(
                                          onTap: () {
                                            String? uId =
                                                customSharedPreferences
                                                    .getStringValue(
                                              'userId',
                                            );
                                            showModalBottomSheet(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Container(
                                                    color: Colors.white,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              int total = lstOrders
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'slots'] -
                                                                  1;

                                                              OrderService()
                                                                  .updateOrder(
                                                                order: {
                                                                  'slots': total
                                                                },
                                                                orderId: lstOrders
                                                                    .docs[index]
                                                                    .id,
                                                              );

                                                              Map<String,
                                                                      dynamic>
                                                                  data = {
                                                                'hourlyRate': lstOrders
                                                                            .docs[
                                                                        index][
                                                                    'hourlyRate'],
                                                                'provinceName':
                                                                    lstOrders.docs[
                                                                            index]
                                                                        [
                                                                        'provinceName'],
                                                                'timeSlot': lstOrders
                                                                            .docs[
                                                                        index][
                                                                    'timeSlot'],
                                                                'slotBookTime':
                                                                    DateTime.now()
                                                                        .toLocal(),
                                                                'bookParkingSet':
                                                                    "1",
                                                                'uId': uId,
                                                              };
                                                              OrderService()
                                                                  .bookSlotData(
                                                                order: data,
                                                              );
                                                              Fluttertoast
                                                                  .showToast(
                                                                msg:
                                                                    "Parking has been booked.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                              );
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: const Text(
                                                              "K-Net",
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .primaryColor3,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                              onTap: () {
                                                                int total =
                                                                    lstOrders.docs[index]
                                                                            [
                                                                            'slots'] -
                                                                        1;

                                                                OrderService()
                                                                    .updateOrder(
                                                                  order: {
                                                                    'slots':
                                                                        total
                                                                  },
                                                                  orderId: lstOrders
                                                                      .docs[
                                                                          index]
                                                                      .id,
                                                                );

                                                                Map<String,
                                                                        dynamic>
                                                                    data = {
                                                                  'hourlyRate':
                                                                      lstOrders.docs[
                                                                              index]
                                                                          [
                                                                          'hourlyRate'],
                                                                  'provinceName':
                                                                      lstOrders.docs[
                                                                              index]
                                                                          [
                                                                          'provinceName'],
                                                                  'timeSlot': lstOrders
                                                                              .docs[
                                                                          index]
                                                                      [
                                                                      'timeSlot'],
                                                                  'slotBookTime':
                                                                      DateTime.now()
                                                                          .toLocal(),
                                                                  'bookParkingSet':
                                                                      "1",
                                                                  'uId': uId,
                                                                };
                                                                OrderService()
                                                                    .bookSlotData(
                                                                  order: data,
                                                                );
                                                                Fluttertoast
                                                                    .showToast(
                                                                  msg:
                                                                      "Parking has been booked.",
                                                                  toastLength: Toast
                                                                      .LENGTH_SHORT,
                                                                );
                                                                Navigator.pop(
                                                                    context);
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                "Cash",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: AppColors
                                                                      .primaryColor3,
                                                                ),
                                                              )),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          title: "Book Parking",
                                          textStyle: GoogleFonts.sofiaSans(
                                            textStyle: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontStyle: FontStyle.normal,
                                              fontSize: 20,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            lstOrders.docs[index]
                                                ['provinceName'],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_city,
                                              ),
                                              Text(
                                                lstOrders.docs[index]
                                                    ['provinceName'],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topLeft,
                                                end: Alignment.bottomRight,
                                                colors: [
                                                  Color(0xFFA5D6A7),
                                                  Color(0xFF4CAF50),
                                                ],
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    lstOrders.docs[index]
                                                            ['slots']
                                                        .toString(),
                                                  ),
                                                  const Text(
                                                    "Available Spots",
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Color(0xFFEEEEEE),
                                          Color(0xFFBDBDBD),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.money,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            lstOrders.docs[index]['hourlyRate']
                                                .toString(),
                                          ),
                                          const SizedBox(
                                            width: 20.0,
                                          ),
                                          const Icon(
                                            Icons.history,
                                          ),
                                          const SizedBox(
                                            width: 8.0,
                                          ),
                                          Text(
                                            lstOrders.docs[index]['timeSlot']
                                                .toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ));
                  },
                );
        }
      },
    );
  }
}
