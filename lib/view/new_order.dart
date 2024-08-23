import 'package:flutter/material.dart';
import 'package:gents_trailer/constant/authentication_variable.dart';
import 'package:gents_trailer/constant/constant_controller.dart';
import 'package:gents_trailer/constant/constant_string.dart';

import '../model/firebase_model.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({super.key, required this.onAddOrder});

  final void Function(FirebaseModel fModel) onAddOrder;

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  final plength1 = double.tryParse(plengthController.text) ?? 0.0;
  final kamar1 = double.tryParse(kamarController.text) ?? 0.0;
  final seat1 = double.tryParse(seatController.text) ?? 0.0;
  final jang1 = double.tryParse(jangController.text) ?? 0.0;
  final ghutan1 = double.tryParse(ghutanController.text) ?? 0.0;
  final jolo1 = double.tryParse(joloController.text) ?? 0.0;
  final moli1 = double.tryParse(moliController.text) ?? 0.0;
  final slength1 = double.tryParse(slengthController.text) ?? 0.0;
  final front1 = double.tryParse(frontController.text) ?? 0.0;
  final chhati1 = double.tryParse(chhatiController.text) ?? 0.0;
  final solder1 = double.tryParse(solderController.text) ?? 0.0;
  final bay1 = double.tryParse(bayController.text) ?? 0.0;
  final kolar1 = double.tryParse(kolarController.text) ?? 0.0;
  final cup1 = double.tryParse(cupController.text) ?? 0.0;

  void _submitData() {
    if (plengthController.text.isEmpty ||
        kamarController.text.isEmpty ||
        seatController.text.isEmpty ||
        jangController.text.isEmpty ||
        ghutanController.text.isEmpty ||
        joloController.text.isEmpty ||
        moliController.text.isEmpty ||
        slengthController.text.isEmpty ||
        frontController.text.isEmpty ||
        chhatiController.text.isEmpty ||
        solderController.text.isEmpty ||
        bayController.text.isEmpty ||
        kolarController.text.isEmpty ||
        cupController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }
    widget.onAddOrder(FirebaseModel(
        plength: plength1,
        front: front1,
        chhati: chhati1,
        seat: seat1,
        jang: jang1,
        ghutan: ghutan1,
        jolo: jolo1,
        moli: moli1,
        kamar: kamar1,
        slength: slength1,
        solder: solder1,
        bay: bay1,
        kolar: kolar1,
        cup: cup1));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Order saved successfully')));

    Navigator.pop(context);
    final currentUser = AuthenticationVar.firebase.currentUser;
    if (currentUser != null) {
      try {
        AuthenticationVar.firestore.collection('orders').add({
          'userId': currentUser.uid,
          'plength': plength1,
          'kamar': kamar1,
          'seat': seat1,
          'jang': jang1,
          'ghutan': ghutan1,
          'jolo': jolo1,
          'moli': moli1,
          'slength': slength1,
          'front': front1,
          'chhati': chhati1,
          'solder': solder1,
          'bay': bay1,
          'kolar': kolar1,
          'cup': cup1
        });
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save order: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              const Text(
                "PENT",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Container(
                height: 435,
                width: 400,
                color: Colors.white,
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        myTextField(plengthController, lambay),
                        const SizedBox(height: 10),
                        myTextField(kamarController, kamar),
                        const SizedBox(height: 10),
                        myTextField(seatController, seat),
                        const SizedBox(height: 10),
                        myTextField(jangController, jang),
                        const SizedBox(height: 10),
                        myTextField(ghutanController, ghutun),
                        const SizedBox(height: 10),
                        myTextField(joloController, jolo),
                        const SizedBox(height: 10),
                        myTextField(moliController, moli),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "SHIRT",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                ),
              ),
              Container(
                height: 435,
                width: 400,
                color: Colors.white,
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        myTextField(slengthController, lambay),
                        const SizedBox(height: 10),
                        myTextField(frontController, front),
                        const SizedBox(height: 10),
                        myTextField(chhatiController, chhati),
                        const SizedBox(height: 10),
                        myTextField(solderController, soldar),
                        const SizedBox(height: 10),
                        myTextField(bayController, bay),
                        const SizedBox(height: 10),
                        myTextField(kolarController, kolar),
                        const SizedBox(height: 10),
                        myTextField(cupController, cup),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitData,
                    child: const Text(
                      "Save Order",
                      style: TextStyle(color: Colors.green, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myTextField(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            hintText: text,
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
