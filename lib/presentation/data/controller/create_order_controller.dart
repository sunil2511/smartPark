import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/data/order_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController idController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController perUnitController = TextEditingController();

  final TextEditingController totalAmountController = TextEditingController();

  updateOrderData() async {
    try {
      isLoading.value = true;
      update();
      if (formKey.currentState!.validate() &&
          idController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          perUnitController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          totalAmountController.text.isNotEmpty) {
        Map<String, dynamic> data = {
          'id': idController.text,
          'order_name': nameController.text,
          'price': priceController.text,
          'per_unit': perUnitController.text,
          'total_amount': totalAmountController.text,
        };

        OrderService().updateOrder(
          orderId: idController.text ?? '1',
          order: data,
        );
        isLoading.value = false;
        update();
        Fluttertoast.showToast(msg: "Order updated successfully");
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      update();
      Fluttertoast.showToast(msg: e.code.toString());
    }
  }

  createOrderData() async {
    try {
      isLoading.value = true;
      update();
      if (formKey.currentState!.validate() &&
          idController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          perUnitController.text.isNotEmpty &&
          priceController.text.isNotEmpty &&
          totalAmountController.text.isNotEmpty) {
        Map<String, dynamic> data = {
          'id': idController.text,
          'order_name': nameController.text,
          'price': priceController.text,
          'per_unit': perUnitController.text,
          'total_amount': totalAmountController.text,
        };

        // /
        isLoading.value = false;
        update();
        Fluttertoast.showToast(msg: "Order created successfully");
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      update();
      Fluttertoast.showToast(msg: e.code.toString());
    }
  }
}
