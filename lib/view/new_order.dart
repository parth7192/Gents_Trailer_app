import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constant/authentication_variable.dart';
import '../constant/constant_controller.dart';
import '../constant/constant_string.dart';
class NewOrder extends StatefulWidget {
  const NewOrder({super.key});
  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  // @override
  // void dispose() {
  //   plengthFocusNode.dispose();
  //   kamarFocusNode.dispose();
  //   seatFocusNode.dispose();
  //   jangFocusNode.dispose();
  //   ghutanFocusNode.dispose();
  //   joloFocusNode.dispose();
  //   moliFocusNode.dispose();
  //   slengthFocusNode.dispose();
  //   frontFocusNode.dispose();
  //   chhatiFocusNode.dispose();
  //   solderFocusNode.dispose();
  //   bayFocusNode.dispose();
  //   kolarFocusNode.dispose();
  //   cupFocusNode.dispose();
  //   nameFocusNode.dispose();
  //   plengthController.dispose();
  //   ghutanController.dispose();
  //   jangController.dispose();
  //   seatController.dispose();
  //   joloController.dispose();
  //   moliController.dispose();
  //   kamarController.dispose();
  //   slengthController.dispose();
  //   frontController.dispose();
  //   chhatiController.dispose();
  //   solderController.dispose();
  //   bayController.dispose();
  //   kolarController.dispose();
  //   cupController.dispose();
  //   emailController.dispose();
  //   usernameController.dispose();
  //   passwordController.dispose();
  //
  //   billNoController.dispose();
  //   mobileFocusNode.dispose();
  //   super.dispose();
  // }

  void _submitData() async {
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
    final name = nameController.text;
    final mobileNo = mobileController.text;
    final billNo = billNoController.text;

    // Check if any field is empty
    if (plengthController.text.isEmpty ||
        name.isEmpty ||
        mobileNo.isEmpty ||
        billNo.isEmpty ||
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

    final currentUser = AuthenticationVar.firebase.currentUser;
    if (currentUser != null) {
      // Check if the bill number already exists
      final querySnapshot = await AuthenticationVar.firestore
          .collection('order')
          .doc(currentUser.email)
          .collection('orders')
          .where('billNo', isEqualTo: billNo)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Bill number already exists
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Bill number already exists')),
        );
        return;
      }

      try {
        // Add new order if the bill number does not exist
        AuthenticationVar.firestore
            .collection('order')
            .doc(currentUser.email)
            .collection('orders')
            .add({
          'name': name,
          'mobileNo': mobileNo,
          'billNo': billNo,
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
          'cup': cup1,
          'userId': currentUser.uid,
        });
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
        nameController.clear();
        mobileController.clear();
        billNoController.clear();

        Navigator.pop(context);

      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save order: $error')),
        );
      }
    }
  }
  // void _presentDatePicker() async {
  //   final now = DateTime.now();
  //   final pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: now,
  //     firstDate: now,
  //     lastDate: DateTime(2050),
  //   );
  //   setState(() {
  //     _selectedDate = pickedDate;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "New Order",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        backgroundColor: Colors.teal,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTopForm(),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        "PENT DETAILS",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildPentForm(),
                      const SizedBox(height: 20),
                      Text(
                        "SHIRT DETAILS",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal[700],
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildShirtForm(),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _submitData,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Save Order",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPentForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: myTextField(
                  plengthController, lambay, plengthFocusNode, kamarFocusNode),
            ),
            Expanded(
              child: myTextField(
                  kamarController, kamar, kamarFocusNode, seatFocusNode),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: myTextField(
                  joloController, jolo, seatFocusNode, jangFocusNode),
            ),
            Expanded(
              child: myTextField(
                  seatController, seat, jangFocusNode, ghutanFocusNode),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: myTextField(
                  jangController, jang, ghutanFocusNode, joloFocusNode),
            ),
            Expanded(
              child: myTextField(
                  ghutanController, ghutun, joloFocusNode, moliFocusNode),
            ),
          ],
        ),
        myTextField(moliController, moli, moliFocusNode, null),
      ],
    );
  }

  Widget _buildShirtForm() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: myTextField(
                  slengthController, lambay, slengthFocusNode, frontFocusNode),
            ),
            Expanded(
              child: myTextField(
                  frontController, front, frontFocusNode, chhatiFocusNode),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: myTextField(
                  chhatiController, chhati, chhatiFocusNode, solderFocusNode),
            ),
            Expanded(
              child: myTextField(
                  solderController, soldar, solderFocusNode, bayFocusNode),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child:
              myTextField(bayController, bay, bayFocusNode, kolarFocusNode),
            ),
            Expanded(
              child: myTextField(
                  kolarController, kolar, kolarFocusNode, cupFocusNode),
            ),
          ],
        ),
        myTextField(cupController, cup, cupFocusNode, null),
      ],
    );
  }

  Widget myTextField(TextEditingController controller, String label,
      FocusNode currentFocus, FocusNode? nextFocus,
      {TextInputType? keyboard, List<TextInputFormatter>? inputFormatters}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: TextField(
        controller: controller,
        focusNode: currentFocus,
        keyboardType: keyboard ?? TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(color: Colors.teal),
          ),
        ),
        inputFormatters: inputFormatters,
        onSubmitted: (value) {
          if (nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }

  Widget _buildTopForm() {
    return Column(
      children: [
        myTextField(nameController, "Name", nameFocusNode, mobileFocusNode,
            keyboard: TextInputType.text),
        Row(
          children: [
            // Expanded widgets to make both fields responsive
            Expanded(
              child: myTextField(
                mobileController,
                "Mobile Number",
                mobileFocusNode,
                billNoFocusNode,
              ),
            ),
            const SizedBox(width: 10), // Add space between the fields
            Expanded(
              child: myTextField(
                billNoController,
                "Bill No",
                billNoFocusNode,
                null,
              ),
            ),
          ],
        ),

        // Expanded(
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       IconButton(
        //         onPressed: _presentDatePicker,
        //         icon: const Icon(
        //           Icons.calendar_month,
        //         ),
        //       ),
        //       Text(
        //         _selectedDate == null
        //             ? 'No date selected'
        //             : formatter.format(_selectedDate!),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
