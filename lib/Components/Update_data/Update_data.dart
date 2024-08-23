import 'package:budget_tracker/Controller/budjet_controller.dart';
import 'package:budget_tracker/Utils/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


IconButton buildIconButton(BuildContext context, HomeController controller, int index) {
  return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Update your record",style: TextStyle(fontWeight: FontWeight.bold),),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildTextField(
                    labelText: 'Amount',
                    controller: controller.txtAmount,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buildTextField(
                    labelText: 'Category',
                    controller: controller.txtCategory,
                  ),
                  Obx(
                        () => SwitchListTile(
                      activeTrackColor:
                      Colors.green.shade600,
                      title: const Text('Income'),
                      value: controller.isIncome.value,
                      onChanged: (value) {
                        controller.setIncome(value);
                      },
                    ),
                  ),
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
                    double.parse(
                        controller.txtAmount.text),
                    controller.isIncome.value ? 1 : 0,
                    controller.txtCategory.text,
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


TextField buildTextField({
  required String labelText,
  required var controller,
}) {
  return TextField(
    cursorColor: Colors.grey,
    controller: controller,
    decoration: InputDecoration(enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      labelText: labelText,
      labelStyle: const TextStyle(),
    ),
  );
}