import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
import 'package:lynerdoctor/generated/locale_keys.g.dart';

class CommonStepIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final Function(int) onStepTapped;
  final Map<int, bool> stepErrors;

  CommonStepIndicator({
    required this.totalSteps,
    required this.stepErrors,
    required this.currentStep,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width, // Set the width of the container to the screen width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          bool isActive = index == currentStep;
          bool isCompleted =
              (index < currentStep || stepErrors[index] == false);
          bool hasError = stepErrors[index] ?? false;
          return GestureDetector(
            onTap: () {
              onStepTapped(index);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: (isActive || isCompleted)
                                ? (hasError ? Colors.red : primaryBrown)
                                : (hasError ? Colors.red : darkSkyColor),
                            width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: !isTablet ? 20 : 25,
                        height: !isTablet ? 20 : 25,
                        decoration: BoxDecoration(
                          color: isActive
                              ? (hasError ? Colors.red : primaryBrown)
                              : isCompleted
                                  ? (hasError ? Colors.red : primaryBrown)
                                  : (hasError ? Colors.red : darkSkyColor),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? (!hasError
                                  ? Assets.icons.icSelect.svg(
                                      alignment: Alignment.center, width: 12)
                                  : null)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 4), // Space between the circle and number
                    Text(
                      '${LocaleKeys.steps.translateText} ${index + 1}',
                      // Step number
                      style: TextStyle(
                        fontSize: !isTablet ? 12 : 16,
                        fontFamily: Assets.fonts.maax,
                        fontWeight: FontWeight.normal,
                        color: isActive || isCompleted
                            ? Colors.black
                            : hintStepColor,
                      ),
                    ),
                  ],
                ),
                if (index != totalSteps - 1)
                  Container(
                    width: (Get.width - (!isTablet ? 50 : 65) * totalSteps) /
                        (totalSteps - 1),
                    // Adjust width to fill the screen
                    height: 2.0,
                    color: index < currentStep ? primaryBrown : darkSkyColor,
                  ).paddingOnly(top: 15).paddingSymmetric(horizontal: 0),
              ],
            ),
          );
        }),
      ),
    );
  }
}
