import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/constants/request_const.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DownloadProgressDialog extends StatelessWidget {
  final double progress;
  final String count;

  const DownloadProgressDialog({
    super.key,
    required this.progress,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Container(
        color: Colors.black38,
        width: Get.width,
        height: Get.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Center(
            child: Container(
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularPercentIndicator(
                    radius: 40,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: primaryBrown,
                    backgroundColor: const Color(0xFFDADADA),
                    lineWidth: 5,
                    percent: downloadProgress / 100,
                    center: Text(
                      '$downloadProgress%',
                      style: TextStyle(
                        color: primaryBrown,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  5.0.space(),
                  Text(
                    count,
                    style: const TextStyle(
                      color: primaryBrown,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
