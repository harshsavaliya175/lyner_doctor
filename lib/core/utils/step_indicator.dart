import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';

class CommonStepIndicator extends StatelessWidget {
  final int totalSteps;
  final RxInt currentStep;
  final Function(int) onStepTapped;

  CommonStepIndicator({
    required this.totalSteps,
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
          bool isActive = index == currentStep.value;
          bool isCompleted = index < currentStep.value;
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
                            color: isActive || isCompleted
                                ? primaryBrown
                                : darkSkyColor,
                            width: 1),
                        shape: BoxShape.circle,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: isActive
                              ? primaryBrown
                              : isCompleted
                              ? primaryBrown
                              : darkSkyColor,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: isCompleted
                              ? Assets.icons.icSelect
                              .svg(alignment: Alignment.center,width: 12)
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(height: 4), // Space between the circle and number
                    Text(
                      'Steps ${index + 1}', // Step number
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: Assets.fonts.maax,
                        fontWeight: FontWeight.normal,
                        color: isActive||isCompleted? Colors.black : hintStepColor,
                      ),
                    ),
                  ],
                ),
                if (index != totalSteps - 1)
                  Container(
                    width: (Get.width - 50.0 * totalSteps) / (totalSteps - 1),
                    // Adjust width to fill the screen
                    height: 2.0,
                    color: index < currentStep.value
                        ? primaryBrown
                        : darkSkyColor,
                  ).paddingOnly(top: 15).paddingSymmetric(horizontal: 0),
              ],
            ),
          );
        }),
      ),
    );
  }
}