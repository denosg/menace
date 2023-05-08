import 'package:flutter/material.dart';
import 'package:menace/screens/video_swiper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoSwiper(),
    );
  }
}
