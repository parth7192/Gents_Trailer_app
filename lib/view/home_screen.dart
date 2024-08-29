import 'package:flutter/material.dart';
import 'package:gents_trailer/widget/custome_card.dart';
import 'package:get/get.dart';
import '../constant/authentication_variable.dart';
import '../getx/getx.dart';
import 'auth/authentication.dart';
import 'new_order.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  void logout() {
    AuthenticationVar.firebase.signOut();
  }

  TailorController tailorController = Get.put(TailorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Order Management',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        actions: [
          IconButton(
            onPressed: () {
              logout();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AuthScreen(),
              ));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Obx(() {
        if (tailorController.registeredOrder.isEmpty) {
          return const Center(
            child: Text(
              'No orders available',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          );
        } else {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: tailorController.filteredOrders.length,
            itemBuilder: (context, index) {
              final order = tailorController.filteredOrders[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Dismissible(
                  key: Key(order.id.toString()),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    tailorController.removeOrder(order);
                  },
                  background: Container(
                    decoration: BoxDecoration(
                      color: Colors.teal.shade100,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: OrderCard(
                    model: order,
                  ),
                ),
              );
            },
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NewOrder(),
          ));
        },
        icon: const Icon(Icons.add),
        label: const Text(
          'Add Order',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
