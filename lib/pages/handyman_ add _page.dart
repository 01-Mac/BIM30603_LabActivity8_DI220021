import 'package:flutter/material.dart';
import 'package:labactivity8/components/my_button.dart';
import 'package:labactivity8/components/my_snackbar.dart';
import 'package:labactivity8/components/my_textfield.dart';
import 'package:labactivity8/services/database_method.dart';
import 'package:random_string/random_string.dart';

class HandymanAddPage extends StatefulWidget {
  const HandymanAddPage({super.key});

  @override
  State<HandymanAddPage> createState() => _HandymanAddPageState();
}

class _HandymanAddPageState extends State<HandymanAddPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController serviceController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void saveHandymanInfo() async {
    String id = randomAlphaNumeric(10);
    String res = "";
    Map<String, dynamic> handymanInfoMap = {
      "Id": id,
      "Name": nameController.text,
      "Service": serviceController.text,
      "Location": locationController.text,
      "Phone": phoneController.text,
    };

    await DatabaseMethod().addHandymanInfo(handymanInfoMap, id);
    res = "Handyman details have been saved successfully.";
    showSnackBar(context, res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Handyman Information"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Please insert handyman details:",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            MyTextfield(
              controller: nameController,
              hintText: "Name",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextfield(
              controller: serviceController,
              hintText: "Type of Service",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextfield(
              controller: locationController,
              hintText: "Location",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyTextfield(
              controller: phoneController,
              hintText: "Phone Number",
              obscureText: false,
            ),
            const SizedBox(height: 20),
            MyButton(
              text: "Save",
              onTap: saveHandymanInfo,
            ),
          ],
        ),
      ),
    );
  }
}
