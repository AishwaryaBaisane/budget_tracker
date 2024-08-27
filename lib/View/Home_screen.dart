import 'dart:io';
import 'package:budget_tracker/Components/Add_data/add_data.dart';
import 'package:budget_tracker/Components/Update_data/Update_data.dart';
import 'package:budget_tracker/Controller/budjet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: const Text('Budget Tracker',style: TextStyle(color: Colors.white),),
        shadowColor: Colors.white,
        elevation: 4,
      ),
      body: Obx(
        () => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  controller.searchRecord(value);
                },
                controller: controller.txtSearch,
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.close),
                  ),
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search data',
                  hintStyle: const TextStyle(color: Colors.black),
                  fillColor: Colors.black,
                  enabledBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.readIncomeRecord(1);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'Income : ',
                                style: TextStyle(fontSize: 17.3),
                              ),
                              Text(
                                controller.totalIncome.value.toString(),
                                style:
                                const TextStyle(color: Colors.green, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.readIncomeRecord(0);
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'Expense : ',
                                style: TextStyle(fontSize: 17.3),
                              ),
                              Text(controller.totalExpense.value.toString(),
                                  style:
                                  const TextStyle(color: Colors.red, fontSize: 17)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.getRecords();
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Text(
                                'All Data : ',
                                style: TextStyle(fontSize: 17.3),
                              ),
                              Text(controller.totalExpense.value.toString() + controller.totalIncome.value.toString(),
                                  style:
                                  const TextStyle(color: Colors.blue, fontSize: 17)),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(9),
                  child: Card(
                    color: controller.data[index]['isIncome'] == 1
                        ? Colors.green.shade200
                        : Colors.red.shade200,
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: FileImage(File(controller.data[index]['img'])),
                        ),
                        title:
                            Text(controller.data[index]['amount'].toString()),
                        subtitle:
                            Text(controller.data[index]['category'].toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            buildIconButton(context, controller, index),
                            IconButton(
                                onPressed: () {
                                  controller.removeRecord(
                                    int.parse(
                                      controller.data[index]['id'].toString(),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        )),
                  ),
                ),
                itemCount: controller.data.length,
              ),
            )
          ],
        ),
      ),
      floatingActionButton: buildFloatingActionButton(context, controller),
    );
  }
}
// var selectIndex = 0;