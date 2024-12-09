import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mamamia_uniproject/components/normal_appbar.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NormalAppBar("Help Center".tr),
      body: const Center(
        child: Column(
          //
          children: [
            Text('this is the help center page'),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/me.jpg'),
            ),
            Text('who did it all '),
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage('assets/images/thebitches.jpg'),
            ),
            Text('the bitches '),
          ],
        ),
      ),
    );
  }
}
