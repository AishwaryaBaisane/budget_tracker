import 'dart:io';
import 'package:budget_tracker/Controller/budjet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

FloatingActionButton buildFloatingActionButton(BuildContext context, HomeController controller) {
  return FloatingActionButton(
    focusColor: Colors.black26,
    backgroundColor: Colors.red,
    onPressed: () {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Add Record',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(
                () => GestureDetector(
                  onTap: () async {
                    ImagePicker imagePicker = ImagePicker();
                    XFile? xFile = await imagePicker.pickImage(
                        source: ImageSource.gallery);
                    String path = xFile!.path;
                    File fileImage = File(path);
                    controller.getImg(fileImage);
                  },
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: (controller.ImgPath != null)
                        ? FileImage(controller.ImgPath!.value)
                        : NetworkImage(controller.dummyImage.value),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              TextField(
                controller: controller.txtAmount,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black38),
                  labelText: 'Amount',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: controller.txtCategory,
                decoration: InputDecoration(
                  labelStyle: TextStyle(color: Colors.black38),
                  labelText: 'Category',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Obx(
                () => SwitchListTile(
                  activeTrackColor: Colors.green,
                  title: const Text('Income'),
                  value: controller.isIncome.value,
                  onChanged: (value) {
                    controller.setIncome(value);
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () {
                  double amount = double.parse(controller.txtAmount.text);
                  int isIncome = controller.isIncome.value ? 1 : 0;
                  String category = controller.txtCategory.text;
                  controller.insertRecord(amount, isIncome, category,
                      controller.ImgPath!.value.path);
                  controller.txtAmount.clear();
                  controller.txtCategory.clear();
                  Get.back();
                  controller.isIncome.value = false;
                },
                child: const Text(
                  'Save',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      );
    },
    child: Text(
      "Add",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  );
}
//   Card(
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Row(
//             children: [
//               const Text(
//                 'Total : ',
//                 style: TextStyle(fontSize: 17.3),
//               ),
//               Text(
//                 controller.totalIncome.value.toString(),
//                 style:
//                 const TextStyle(color: Colors.green, fontSize: 17),
//               ),
//             ],
//           ),
//         ),
//       ),