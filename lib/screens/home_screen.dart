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
  List<bool> _videoLoadedList = [];
  List<VideoPlayerController> _videoControllers = [];
  List<String> _videos = [];

  Future<void> loadVideoPlayer() async {
    print('loading...');
    final videoLoader = Provider.of<VideoProvider>(context, listen: false);
    await videoLoader.loadVideosFromPH();
    final videoData = videoLoader.videos;
    setState(() {
      _videos = videoData;
    });
  }

  Future<void> _initializeVideoControllers() async {
    // initialize list of videos for video player
    await loadVideoPlayer();
    print(_videos);
    for (String videoUrl in _videos) {
      final controller = VideoPlayerController.network(videoUrl)
        ..initialize().then((_) {
          setState(() {
            _videoLoadedList.add(true);
          });
        });
      _videoControllers.add(controller);
      _videoLoadedList.add(false);
    }
  }

  @override
  void initState() {
    super.initState();
    // initialize the controller for each video
    _initializeVideoControllers();
  }

  // clean memory
  @override
  void dispose() {
    super.dispose();
    _disposeVideoControllers();
  }

  // clean memory
  void _disposeVideoControllers() {
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    _videoControllers.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          // init the controller for the current video
          final videoController = _videoControllers[index];
          videoController.setLooping(true);
          videoController.play();
          return FutureBuilder(
            future: videoController.initialize(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return InkWell(
                  onTap: () {
                    if (videoController.value.isPlaying) {
                      videoController.pause();
                    } else {
                      videoController.play();
                    }
                  },
                  child: AspectRatio(
                    aspectRatio: 16.0 / 9.0,
                    child: VideoPlayer(videoController),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
        itemCount: _videos.length,
      ),
    );
  }
}
