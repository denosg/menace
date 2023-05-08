import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../providers/video_provider.dart';

class VideoSwiper extends StatefulWidget {
  @override
  _VideoSwiperState createState() => _VideoSwiperState();
}

class _VideoSwiperState extends State<VideoSwiper> {
  SwiperController _controller = SwiperController();

  @override
  void initState() {
    // gets PH videos
    Provider.of<VideoProvider>(context, listen: false).getVideosFromPH();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoProvider>(
      builder: (context, videoData, _) => Swiper(
        itemCount: videoData.videos.length,
        itemBuilder: (BuildContext context, int index) {
          return Chewie(
            controller: ChewieController(
              videoPlayerController: VideoPlayerController.network(
                videoData.videos[index],
              ),
              autoPlay: true,
              looping: true,
              showControls: false,
            ),
          );
        },
        loop: false,
        controller: _controller,
        onIndexChanged: (index) {},
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
