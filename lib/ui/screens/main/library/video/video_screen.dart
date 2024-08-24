import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lynerdoctor/core/constants/app_color.dart';
import 'package:lynerdoctor/gen/assets.gen.dart';
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
    String videoUrl = ctrl.youtubeUrl;
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
        ),
      );
    } else {
      print("Failed to extract video ID from URL");
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _youtubeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBgColor,
        body: GetBuilder<LibraryController>(builder: (ctrl) {
          double aspectRatio =
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? 9 / 16
                  : 16 / 9;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*  30.space(),
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                tooltip: "Back",
              ),*/

              Expanded(
                child: YoutubePlayer(
                  thumbnail: Assets.images.imgAppLogo.image(
                    fit: BoxFit.fill,
                  ),
                  controller: _youtubeController,
                  showVideoProgressIndicator: false,
                  topActions: [
                    SafeArea(
                      child: GestureDetector(
                        onTap: () {
                          SystemChrome.setPreferredOrientations(
                              [DeviceOrientation.portraitUp]);
                          Get.back(); // Navigate back on tap
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ).paddingOnly(left: 10),
                  ],
                  progressIndicatorColor: Colors.red,
                  onReady: () {
                    print('Player is ready.');
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
