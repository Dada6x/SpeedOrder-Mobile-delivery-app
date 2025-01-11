import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerificationController extends GetxController {
  final correctCode = "1234"; // Replace with any hardcoded value for testing.
  var enteredCode = "".obs;

  void verifyCode() {
    if (enteredCode.value == correctCode) {
      Get.defaultDialog(
        title: "Success",
        middleText: "Code verified successfully!",
        onConfirm: () {
          Get.back(); // Close dialog
          Get.back();
        },
        textConfirm: "OK",
      );
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "Invalid code. Please try again.",
        textConfirm: "OK",
        onConfirm: () => Get.back(),
      );
    }
  }
}

class CodeVerificationPage extends StatelessWidget {
  final CodeVerificationController controller =
      Get.put(CodeVerificationController());

  CodeVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enter Verification Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Enter the 4-digit code sent to your Number',
              // GEt the User Number
              // make an screen to take the user number

              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            PinCodeTextField(
              appContext: context,
              length: 4,
              obscureText: false,
              animationType: AnimationType.fade,
              keyboardType: TextInputType.number,
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                borderRadius: BorderRadius.circular(8),
                fieldHeight: 50,
                fieldWidth: 40,
                activeColor: MainPage.orangeColor,
                selectedColor: MainPage.greyColor,
                inactiveColor: Colors.grey,
              ),
              hintCharacter: '0',
              hintStyle: const TextStyle(color: Colors.grey, fontSize: 20),
              onChanged: (value) {
                controller.enteredCode.value = value; // Update entered code
              },
              onCompleted: (value) {
                controller.verifyCode(); // Verify code when input is complete
              },
            ),
            ProjectButton(text: 'send', width: screenWidth(context) * 0.1)
          ],
        ),
      ),
    );
  }
}
