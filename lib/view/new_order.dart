import 'package:flutter/material.dart';
import 'package:gents_trailer/constant/constant.dart';

class NewOrder extends StatefulWidget {
  NewOrder({super.key});

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
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
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
                        myTextField(widget.plengthController, lambay),
                        const SizedBox(height: 10),
                        myTextField(widget.kamarController, kamar),
                        const SizedBox(height: 10),
                        myTextField(widget.seatController, seat),
                        const SizedBox(height: 10),
                        myTextField(widget.jangController, jang),
                        const SizedBox(height: 10),
                        myTextField(widget.ghutanController, ghutun),
                        const SizedBox(height: 10),
                        myTextField(widget.joloController, jolo),
                        const SizedBox(height: 10),
                        myTextField(widget.moliController, moli),
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
                        myTextField(widget.slengthController, lambay),
                        const SizedBox(height: 10),
                        myTextField(widget.frontController, front),
                        const SizedBox(height: 10),
                        myTextField(widget.chhatiController, chhati),
                        const SizedBox(height: 10),
                        myTextField(widget.solderController, soldar),
                        const SizedBox(height: 10),
                        myTextField(widget.bayController, bay),
                        const SizedBox(height: 10),
                        myTextField(widget.kolarController, kolar),
                        const SizedBox(height: 10),
                        myTextField(widget.cupController, cup),
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

  Widget myTextField(TextEditingController controller, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextFormField(
        controller: controller,
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
