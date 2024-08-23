import 'package:flutter/material.dart';
import 'package:gents_trailer/constant/constant.dart';

class Widgets extends StatefulWidget {
  Widgets({super.key});

  TextEditingController plengthController = TextEditingController();
  TextEditingController kamarController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  TextEditingController jangController = TextEditingController();
  TextEditingController ghutanController = TextEditingController();
  TextEditingController joloController = TextEditingController();
  TextEditingController moliController = TextEditingController();
  TextEditingController slengthController = TextEditingController();
  TextEditingController frontController = TextEditingController();
  TextEditingController chhatiController = TextEditingController();
  TextEditingController solderController = TextEditingController();
  TextEditingController bayController = TextEditingController();
  TextEditingController kolarController = TextEditingController();
  TextEditingController cupController = TextEditingController();

  @override
  State<Widgets> createState() => _WidgetsState();
}

class _WidgetsState extends State<Widgets> {
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
                        MyTextField(widget.plengthController, lambay),
                        const SizedBox(height: 10),
                        MyTextField(widget.kamarController, kamar),
                        const SizedBox(height: 10),
                        MyTextField(widget.seatController, seat),
                        const SizedBox(height: 10),
                        MyTextField(widget.jangController, jang),
                        const SizedBox(height: 10),
                        MyTextField(widget.ghutanController, ghutun),
                        const SizedBox(height: 10),
                        MyTextField(widget.joloController, jolo),
                        const SizedBox(height: 10),
                        MyTextField(widget.moliController, moli),
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
                        MyTextField(widget.slengthController, lambay),
                        const SizedBox(height: 10),
                        MyTextField(widget.frontController, front),
                        const SizedBox(height: 10),
                        MyTextField(widget.chhatiController, chhati),
                        const SizedBox(height: 10),
                        MyTextField(widget.solderController, soldar),
                        const SizedBox(height: 10),
                        MyTextField(widget.bayController, bay),
                        const SizedBox(height: 10),
                        MyTextField(widget.kolarController, kolar),
                        const SizedBox(height: 10),
                        MyTextField(widget.cupController, cup),
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
                    onPressed: () {},
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

  Widget MyTextField(TextEditingController Controller, String Text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: Controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            hintText: Text,
            hintStyle: const TextStyle(color: Colors.white),
            filled: true,
            fillColor: Colors.grey),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
