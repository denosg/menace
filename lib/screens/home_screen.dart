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
  late VideoPlayerController _videoController;
  var _isInit = false;
  bool _isVideoLoaded = false;
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

  void loadListener() {
    if (_videoController.value.isInitialized && !_isInit) {
      _videoController.addListener(() {
        if (_videoController.value.isInitialized && !_isVideoLoaded) {
          setState(() {
            _isVideoLoaded = true;
          });
        }
      });
      _isInit = true;
    } else {
      _isVideoLoaded = false; // reset the flag to false
    }
  }

  @override
  void initState() {
    super.initState();
    // initialize list of videos for video player
    loadVideoPlayer();
    _videoController = VideoPlayerController.network('');
  }

  // clean memory
  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _videos.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PageView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                _isVideoLoaded = false;
                _videoController =
                    VideoPlayerController.network(_videos[index]);
                _videoController.setLooping(true);
                _videoController.play();
                loadListener();
                return _isVideoLoaded
                    ? InkWell(
                        onTap: () {
                          if (_videoController.value.isPlaying) {
                            _videoController.pause();
                          } else {
                            _videoController.play();
                          }
                        },
                        child: AspectRatio(
                          aspectRatio: _videoController.value.aspectRatio,
                          child: VideoPlayer(_videoController),
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: Colors.red,
                        ),
                      );
              },
              itemCount: _videos.length,
            ),
    );
  }
}
