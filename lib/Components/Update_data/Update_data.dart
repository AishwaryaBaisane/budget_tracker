import 'dart:io';

import 'package:budget_tracker/Controller/budjet_controller.dart';
import 'package:budget_tracker/Utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

IconButton buildIconButton(
    BuildContext context, HomeController controller, int index) {
  return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              "Update your record",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Form(
              key: formKey,
              child: Column(
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
                        radius: 30,
                        backgroundImage: (controller.ImgPath != null)
                            ? FileImage(controller.ImgPath!.value)
                            : NetworkImage(controller.dummyImage.value),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: controller.txtAmount,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: controller.data[index]['amount'].toString(),
                      labelStyle: const TextStyle(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    cursorColor: Colors.grey,
                    controller: controller.txtCategory,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: controller.data[index]['category'].toString(),

                      labelStyle: const TextStyle(),
                    ),
                  ),
                  // buildTextField(
                  //   labelText: 'Category',
                  //   text: controller.data[index]['category'],
                  //   controller: controller.txtCategory,
                  // ),
                ],
              ),
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  txtController.clear();
                },
                child: const Text('Cancel'),
              ),
              MaterialButton(
                onPressed: () {
                  controller.updateRecords(
                    controller.data[index]['id'],
                    double.parse(controller.txtAmount.text),
                    controller.isIncome.value ? 1 : 0,
                    controller.txtCategory.text,
                    controller.ImgPath!.value.path,
                  );
                  controller.txtAmount.clear();
                  controller.txtCategory.clear();
                  Navigator.of(context).pop();
                  controller.isIncome.value = false;
                  // txtController.clear();/
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
      icon: const Icon(Icons.edit));
}

// TextField buildTextField({
//   required String labelText,
//   required var controller,
//   required var text
// }) {
//   return TextField(
//     cursorColor: Colors.grey,
//     controller: controller,
//     decoration: InputDecoration(enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10)),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       hintText: text,
//       labelText: labelText,
//       labelStyle: const TextStyle(),
//     ),
//   );
// }
