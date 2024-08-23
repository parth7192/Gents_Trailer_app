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
  final plengthFocusNode = FocusNode();
  final kamarFocusNode = FocusNode();
  final seatFocusNode = FocusNode();
  final jangFocusNode = FocusNode();
  final ghutanFocusNode = FocusNode();
  final joloFocusNode = FocusNode();
  final moliFocusNode = FocusNode();
  final slengthFocusNode = FocusNode();
  final frontFocusNode = FocusNode();
  final chhatiFocusNode = FocusNode();
  final solderFocusNode = FocusNode();
  final bayFocusNode = FocusNode();
  final kolarFocusNode = FocusNode();
  final cupFocusNode = FocusNode();

  // Dispose of focus nodes to avoid memory leaks
  @override
  void dispose() {
    plengthFocusNode.dispose();
    kamarFocusNode.dispose();
    seatFocusNode.dispose();
    jangFocusNode.dispose();
    ghutanFocusNode.dispose();
    joloFocusNode.dispose();
    moliFocusNode.dispose();
    slengthFocusNode.dispose();
    frontFocusNode.dispose();
    chhatiFocusNode.dispose();
    solderFocusNode.dispose();
    bayFocusNode.dispose();
    kolarFocusNode.dispose();
    cupFocusNode.dispose();
    super.dispose();
  }

  void _submitData() {
    // Parse the values from the controllers at the time of submission
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

    // Check if any field is empty
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

    // Pass the order back to the parent widget
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

    // Clear the text fields after saving the order
    plengthController.clear();
    kamarController.clear();
    seatController.clear();
    jangController.clear();
    ghutanController.clear();
    joloController.clear();
    moliController.clear();
    slengthController.clear();
    frontController.clear();
    chhatiController.clear();
    solderController.clear();
    bayController.clear();
    kolarController.clear();
    cupController.clear();

    Navigator.pop(context);

    final currentUser = AuthenticationVar.firebase.currentUser;
    if (currentUser != null) {
      try {
        // Use `set()` with a specific document ID for the current user, so it replaces the order if it already exists
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
                height: 250,
                width: 400,
                color: Colors.white,
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(plengthController, lambay,
                                  plengthFocusNode, kamarFocusNode),
                            ),
                            Expanded(
                              child: myTextField(kamarController, kamar,
                                  kamarFocusNode, seatFocusNode),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(joloController, jolo,
                                  seatFocusNode, jangFocusNode),
                            ),
                            Expanded(
                              child: myTextField(seatController, seat,
                                  jangFocusNode, ghutanFocusNode),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(jangController, jang,
                                  ghutanFocusNode, joloFocusNode),
                            ),
                            Expanded(
                              child: myTextField(ghutanController, ghutun,
                                  joloFocusNode, moliFocusNode),
                            ),
                          ],
                        ),
                        myTextField(moliController, moli, moliFocusNode, null),
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
                height: 250,
                width: 400,
                color: Colors.white,
                child: Form(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(slengthController, lambay,
                                  slengthFocusNode, frontFocusNode),
                            ),
                            Expanded(
                              child: myTextField(frontController, front,
                                  frontFocusNode, chhatiFocusNode),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(chhatiController, chhati,
                                  chhatiFocusNode, solderFocusNode),
                            ),
                            Expanded(
                              child: myTextField(solderController, soldar,
                                  solderFocusNode, bayFocusNode),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: myTextField(bayController, bay,
                                  bayFocusNode, kolarFocusNode),
                            ),
                            Expanded(
                              child: myTextField(kolarController, kolar,
                                  kolarFocusNode, cupFocusNode),
                            ),
                          ],
                        ),
                        myTextField(cupController, cup, cupFocusNode, null),
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

  Widget myTextField(TextEditingController controller, String label,
      FocusNode currentFocus, FocusNode? nextFocus) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        autofocus: true,
        controller: controller,
        focusNode: currentFocus,
        // Set the focus node
        keyboardType: TextInputType.number,
        decoration: InputDecoration(labelText: label),
        onSubmitted: (value) {
          if (nextFocus != null) {
            // Shift focus to the next field
            FocusScope.of(context).requestFocus(nextFocus);
          } else {
            // Close the keyboard if there is no next focus
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}