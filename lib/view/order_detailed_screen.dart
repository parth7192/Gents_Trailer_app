import 'package:flutter/material.dart';
import 'package:gents_trailer/model/firebase_model.dart';

class OrderDetailsScreen extends StatelessWidget {
  final FirebaseModel model;

  const OrderDetailsScreen({super.key, required this.model});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details: ${model.name}'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // This prevents the Column from trying to expand.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Basic Order Information
              const Text(
                "Order Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.grey, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(2),
                },
                children: [
                  TableRow(
                    children: [
                      tableHeader("Name"),
                      tableCell(model.name.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Mobile No"),
                      tableCell(model.mobileNo.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Bill No"),
                      tableCell(model.billNo.toString()),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Date"),
                      tableCell(model.deliveryDate.toString()),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 2, height: 30),
              // Shirt Details
              const Text(
                "Shirt Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.grey, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      tableHeader("Chest"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Length"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Sleeve"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Shoulder"),
                      tableCell(""),
                    ],
                  ),
                ],
              ),
              const Divider(thickness: 2, height: 30),

              // Pant Details
              const Text(
                "Pant Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(color: Colors.grey, width: 1),
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                children: [
                  TableRow(
                    children: [
                      tableHeader("Waist"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Length"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Hip"),
                      tableCell(""),
                    ],
                  ),
                  TableRow(
                    children: [
                      tableHeader("Thigh"),
                      tableCell(""),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                  ),
                  child: const Text(
                    "Back to Orders",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to build table headers
  Widget tableHeader(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  // Helper function to build table cells
  Widget tableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
