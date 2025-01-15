// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
// import 'package:mamamia_uniproject/Auth/model/model.dart';
// import 'package:mamamia_uniproject/image_picker/image_picker.dart';

// class Takeimage extends StatelessWidget {
//   const Takeimage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return const ImagePickingDialog();
//                     });
//               },
//               child: Obx(() {
//                 Get.find<Model>().imageIsPicked.value;
//                 final model = Get.find<Model>();
//                 return model.imageIsPicked.value
//                     ? CircleAvatar(
//                         radius: 80,
//                         backgroundImage: model
//                             .pickedImage.value, // Dynamically show picked image
//                       )
//                     : CircleAvatar(
//                         backgroundColor:
//                             Theme.of(context).colorScheme.secondary,
//                         child: const Icon(
//                           Icons.add_a_photo,
//                           size: 40,
//                           color: Colors.white,
//                         ),
//                       );
//               }),
//             ),
//             Center(
//               child: const Text("next"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
