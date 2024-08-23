import 'package:flutter/material.dart';


import '../model/firebase_model.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.model});

  final FirebaseModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Cup: ${model.cup.toString()}',
                      style: const TextStyle(color: Colors.white)),
                  const Text('Address: ',
                      style: TextStyle(color: Colors.white)),
                  const Text('City:', style: TextStyle(color: Colors.white)),
                  const Text('Date: ', style: TextStyle(color: Colors.white)),
                  const Text('Mobile Number:',
                      style: TextStyle(color: Colors.white)),
                  const Text('Price: ', style: TextStyle(color: Colors.white)),
                  const Text('Advance: ',
                      style: TextStyle(color: Colors.white)),
                  const Text('Category: ',
                      style: TextStyle(color: Colors.white)),
                  const Text('Total Persons: ',
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
