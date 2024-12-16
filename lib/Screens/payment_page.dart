import 'package:flutter/material.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Payment Page"),
      body: const Center(
        child: Text("This is the payment Page "),
      ),
    );
  }
}
