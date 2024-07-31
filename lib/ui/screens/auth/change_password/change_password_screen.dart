import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';
import 'package:lynerdoctor/ui/screens/auth/change_password/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: false,
        title: Text(
          LocaleKeys.changePassword.translateText,
          style: TextStyle(
            fontFamily: Assets.fonts.maax,
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        leading: Assets.icons.icBack
            .svg(
          height: 25,
          width: 25,
          fit: BoxFit.scaleDown,
        )
            .onClick(() {
          Get.back();
        }),
        backgroundColor: Colors.white,
        shadowColor: Colors.grey[300],
        elevation: 0.5,
        scrolledUnderElevation: 0,
      ),
      body: GetBuilder<ChangePasswordController>(
          builder: (ChangePasswordController ctrl) {
        return ListView(
          children: [
            CommonTextField(
              hintText: LocaleKeys.oldPassword.translateText,
              controller: ctrl.oldPasswordController,
              action: TextInputAction.next,
              onChange: (String value) {},
            ),
          ],
        );
      }),
    );
  }
}
