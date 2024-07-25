// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> en = {
  "appName": "Lyner Doctor",
  "register": "Register",
  "logIn": "Log In",
  "registerText": "Create an account to enjoy all the benefits",
  "logInText": "Let’s Log In for explore contiunes",
  "enterEmail": "Enter Email",
  "password": "Password",
  "enterPassword": "Enter password",
  "addNewPatient": "Add New Patient",
  "chooseTheProduct": "Choose the Product",
  "selected": "Selected",
  "notSelected": "Not Selected",
  "next": "Next",
  "patientInformation": "Patient Information",
  "enterName": "Enter name",
  "firstName": "First name",
  "lastName": "Last name",
  "enterEmailAddress": "Enter email address",
  "emailAddress": "E-mail Address",
  "dateField": "DD/MM/YYYY",
  "dateOfBirth": "Date of Birth",
  "select": "___Select___",
  "doctor": "Doctor",
  "billingAddress": "Billing Address",
  "deliveryAddress": "Delivery Address",
  "uploadPhotographs": "Upload Photographs",
  "arcadeTraiter": "Arcade a Traiter"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"en": en};
}
