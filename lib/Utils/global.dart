import 'package:budget_tracker/Controller/budjet_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

var controller = Get.put(HomeController());
TextEditingController txtController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey();