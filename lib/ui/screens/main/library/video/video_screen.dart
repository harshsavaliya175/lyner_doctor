import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/core/utils/extension.dart';
import 'package:lynerdoctor/ui/screens/main/library/library_controller.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final LibraryController ctrl = Get.find<LibraryController>();
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    // Assuming your URL is a valid YouTube video URL.
    String videoUrl = "https://www.youtube.com/watch?v=BBAyRBTfsOU";
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    } else {
      print("Failed to extract video ID from URL");
    }

  }

  @override
  void dispose() {
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: GetBuilder<LibraryController>(builder: (ctrl) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.space(),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                tooltip: "Back",
              ),
              220.space(),
              Container(
                margin: const EdgeInsets.only(right: 5, left: 5),
                height: 200,
                width: double.infinity,
                color: Colors.transparent,
                child: YoutubePlayer(
                  controller: _youtubeController,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.red,
                  onReady: () {
                    print('Player is ready.');
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
