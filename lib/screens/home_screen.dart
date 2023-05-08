import 'package:flutter/material.dart';
import 'package:menace/providers/video_provider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late VideoPlayerController controller;
  var _isInit = false;

  @override
  void initState() {
    if (!_isInit) {
      loadVideoPlayer();
    }
    _isInit = true;
    super.initState();
  }

  Future<void> loadVideoPlayer() async {
    await Provider.of<VideoProvider>(context, listen: false)
        .getVideosFromPH()
        .then((value) {
      final videoList =
          Provider.of<VideoProvider>(context, listen: false).videos;
      controller = VideoPlayerController.network(videoList[2]);
      controller.addListener(() {
        setState(() {});
      });
      controller.initialize().then((value) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Play Video from Assets/URL"),
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(children: [
                    AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: VideoPlayer(controller),
                    ),
                    Container(
                      //duration of video
                      child: Text("Total Duration: " +
                          controller.value.duration.toString()),
                    ),
                    Container(
                        child: VideoProgressIndicator(controller,
                            allowScrubbing: true,
                            colors: VideoProgressColors(
                              backgroundColor: Colors.redAccent,
                              playedColor: Colors.green,
                              bufferedColor: Colors.purple,
                            ))),
                    Container(
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                if (controller.value.isPlaying) {
                                  controller.pause();
                                } else {
                                  controller.play();
                                }

                                setState(() {});
                              },
                              icon: Icon(controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow)),
                          IconButton(
                              onPressed: () {
                                controller.seekTo(Duration(seconds: 0));

                                setState(() {});
                              },
                              icon: Icon(Icons.stop))
                        ],
                      ),
                    )
                  ])),
      ),
    );
  }
}
