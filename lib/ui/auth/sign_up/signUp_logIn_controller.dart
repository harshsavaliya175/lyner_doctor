import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpLogInController extends GetxController{
  bool isLogin = true;
  bool isPasswordVisible = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController
  = TextEditingController();
}