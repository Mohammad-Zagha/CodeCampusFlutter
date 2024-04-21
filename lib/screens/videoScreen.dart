import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoUrl;

  const VideoScreen({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.network('http://192.168.1.104:3000/uploads/' + widget.videoUrl);

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoInitialize: true,
      looping: false,
      allowMuting: true,
      allowedScreenSleep: false,
      autoPlay: true, // Auto play the video on initialization
      showControls: true, // Show video controls
      aspectRatio: 16 / 9, // Set the aspect ratio of the video
      fullScreenByDefault: false, // Don't enable full screen by default
      placeholder: Container(
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                SizedBox(
                  height: 250, // Adjust the height of the video player as needed
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
                // Add other widgets below the video player if needed
              ],
            ),
          ),
          // Add other widgets below the video player if needed
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }
}
