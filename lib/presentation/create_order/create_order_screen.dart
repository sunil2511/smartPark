import 'package:flutter/material.dart';
import 'package:flutter_crud/presentation/data/controller/create_order_controller.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  final String id;
  OrderScreen({
    super.key,
    this.id = "",
  });

  CreateOrderController controller = Get.put(CreateOrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Order'),
      ),
      body: Obx(
        () => (controller.isLoading.value == false)
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: controller.formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
                        decoration:
                            const InputDecoration(labelText: 'Order Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter order name';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.idController,
                        decoration:
                            const InputDecoration(labelText: 'Order ID'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter order ID';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.priceController,
                        decoration:
                            const InputDecoration(labelText: 'Order Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter order price';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.perUnitController,
                        decoration:
                            const InputDecoration(labelText: 'Order Per Unit'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter order per unit';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: controller.totalAmountController,
                        decoration: const InputDecoration(
                            labelText: 'Order Total Amount'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter order total amount';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              controller.updateOrderData();
                            },
                            child: const Text('Update'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.createOrderData();
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
