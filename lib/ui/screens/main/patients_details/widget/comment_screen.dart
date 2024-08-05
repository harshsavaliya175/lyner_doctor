import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/core/utils/extensions.dart';
import 'package:lynerdoctor/core/utils/text_field_widget.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          10.space(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              LocaleKeys.comments.translateText
                  .normalText(fontWeight: FontWeight.w600),
              "19v8L5".normalText(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ],
          ),
          6.space(),
          Expanded(
            child: ListView.separated(
              itemCount: 6,
              padding: EdgeInsets.only(top: 10, bottom: 50),
              separatorBuilder: (BuildContext context, int index) => 12.space(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: lightPinkColor,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: skyColor),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LocaleKeys.clinic.translateText.normalText(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: blackColor,
                          ),
                          "05, Jul 24 06:23 AM".normalText(
                            fontWeight: FontWeight.w500,
                            color: hintStepColor,
                            fontSize: 12,
                          ),
                        ],
                      ),
                      6.space(),
                      "Sending to Clinic Task".normalText(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: blackColor,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CommonTextField(
                  hintText: "Please note your comments",
                ),
              ),
              12.space(),
              FloatingActionButton(
                onPressed: () {},
                child: Assets.icons.icSend.svg(),
                shape: CircleBorder(),
                backgroundColor: primaryBrown,
              ),
            ],
          ).paddingSymmetric(vertical: 15),
        ],
      ),
    );
  }
}
