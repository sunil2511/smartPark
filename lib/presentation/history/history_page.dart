import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/data/controller/order_list_controller.dart';
import 'package:flutter_crud/utils/const/color_schema.dart';
import 'package:flutter_crud/utils/services/shared_preferences.dart';
import 'package:flutter_crud/widgets/helper_widget.dart';
import 'package:get/get.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("History"),
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('bookSlots')
          .where('uId',
              isEqualTo: customSharedPreferences.getStringValue(
                'userId',
              ))
          .snapshots(),
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
                                                          lstOrders.docs[index][
                                                                  'bookParkingSet']
                                                              .toString(),
                                                        ),
                                                        const Text(
                                                          "Booked Parking",
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
                                                            ['bookParkingSet']
                                                        .toString(),
                                                  ),
                                                  const Text(
                                                    "Booked Parking",
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
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  // Container(
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(5),
                                  //     gradient: const LinearGradient(
                                  //       begin: Alignment.topLeft,
                                  //       end: Alignment.bottomRight,
                                  //       colors: [
                                  //         Color(0xFFEEEEEE),
                                  //         Color(0xFFBDBDBD),
                                  //       ],
                                  //     ),
                                  //   ),
                                  //   child: Padding(
                                  //     padding: const EdgeInsets.all(8.0),
                                  //     child: Row(
                                  //       children: [
                                  //         const Icon(
                                  //           Icons.calendar_month,
                                  //         ),
                                  //         const SizedBox(
                                  //           width: 8.0,
                                  //         ),
                                  //         Text(
                                  //           DateF('yyyy-MM-dd HH:mm:ss').format(lstOrders.docs[index]
                                  //                   ['slotBookTime']
                                  //               .toString())
                                  //           ,
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // )
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
