import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/Auth/validation/CodeVerificatioon.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main.dart';

class enterNumber extends StatefulWidget {
  const enterNumber({super.key});

  @override
  State<enterNumber> createState() => _enterNumberState();
}

class _enterNumberState extends State<enterNumber> {
  bool isPasswordVisible = false;
  final formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  //
  String? validatePhoneNumber(String? val) {
    if (val == null || val.isEmpty) {
      return "Number is required";
    }
    if (val.length != 10) {
      return "Input should be 10 numbers";
    }
    if (!val.startsWith('09')) {
      return "Number should start with '09'";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    Icon(
                      Icons.phone_iphone_outlined,
                      size: 80,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const Center(
                child: Text(
              "Enter Your Number",
              style: TextStyle(fontSize: 25),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Form(
                key: formKey,
                child: TextFormField(
                  validator: validatePhoneNumber,
                  onChanged: (_) => formKey.currentState?.validate(),
                  maxLength: 10,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: numberController,
                  decoration: inputDecoration(
                    isPassword: false,
                    context: context,
                    hint: "Enter Number",
                    icon: const Icon(Icons.phone, color: Colors.grey),
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                "We\'ll send an code to your phone number to ",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            const Center(
              child: Text(
                "claim your account back",
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: ProjectButton(
                text: "Send",
                width: 200,
                function: () {
                  userInfo!.setString("code", numberController.text);
                  Get.to(CodeVerificationPage());
                },
              )),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration({
    required bool isPassword,
    required BuildContext context,
    required String hint,
    required Icon icon,
  }) {
    return InputDecoration(
      fillColor: Theme.of(context).colorScheme.secondary,
      filled: true,
      prefixIcon: icon,
      suffixIcon: isPassword
          ? IconButton(
              color: Colors.grey[800],
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: isPasswordVisible
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            )
          : null,
      hintText: hint.tr,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
