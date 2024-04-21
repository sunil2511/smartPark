import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_crud/presentation/data/order_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  fetchOrderList() async {
    try {
      isLoading.value = true;
      update();
      OrderService().fetchOrders();
            isLoading.value = false;
      update();
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      update();
      Fluttertoast.showToast(msg: e.code.toString());
    }
  }
}
