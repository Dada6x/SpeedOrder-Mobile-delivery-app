import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/Button.dart';
import 'package:mamamia_uniproject/main_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeVerificationController extends GetxController {
  final correctCode = "1234";
  var enteredCode = "".obs;

  void verifyCode() {
    if (enteredCode.value == correctCode) {
      Get.defaultDialog(
        title: "Success".tr,
        middleText: "Code verified successfully!",
        onConfirm: () {
          Get.back();
        },
        textConfirm: "OK",
      );
    } else {
      Get.defaultDialog(
        title: "Error".tr,
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
          // mainAxisAlignment: MainAxisAlignment.min,
          children: [
            const SizedBox(
              height: 90,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.verified,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const Text(
              'Enter the 4-digit code sent to your Number ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // userInfo!.getString("code").toString(),
                "0980817760",
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(height: 35),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 35),
              child: PinCodeTextField(
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
                  controller.enteredCode.value = value;
                },
                onCompleted: (value) {
                  //! tst
                  controller.verifyCode();
                },
              ),
            ),
            const Center(
              child: ProjectButton(text: 'Send', width: 200),
            ),
            const SizedBox(
              height: 50,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Didn\'t recive a code?',
                  style: TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
