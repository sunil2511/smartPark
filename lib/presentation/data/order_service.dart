import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class OrderService {
  final CollectionReference ordersCollection =
      FirebaseFirestore.instance.collection('orders');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> bookSlotData({required Map<String, dynamic> order}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('bookSlots').doc(order['id']);
    documentReference.set(order).then((value) {
      print('Data added successfully');
    }).catchError((error) {
      print('Failed to add data: $error');
    });
  }

  Future<void> registerUser({
    required Map<String, dynamic> user,
    required String userId,
  }) async {
    userCollection.doc(userId).set(user).then((value) {
      Fluttertoast.showToast(msg: "User registered successfully");
    }).catchError((error) {
      Fluttertoast.showToast(msg: 'Failed to add data: $error');
    });
  }

  Future<void> updateOrder(
      {required orderId, required Map<String, dynamic> order}) async {
    await FirebaseFirestore.instance
        .collection('parkingLocations')
        .doc(orderId)
        .update(order);
  }

  Future<void> deleteOrder(String orderId) async {
    await ordersCollection.doc(orderId).delete();
  }

  fetchOrders() async {
    await FirebaseFirestore.instance.collection('parkingLocations').snapshots();
  }

  fetchUsersData() async {
    await FirebaseFirestore.instance.collection('parkingLocations').snapshots();
  }
}
