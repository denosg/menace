import 'package:flutter/material.dart';
import 'package:menace/providers/video_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Consumer<VideoProvider>(
        builder: (context, videoData, _) => ElevatedButton(
          onPressed: videoData.getVideosFromPH,
          child: const Text('test'),
        ),
      ),
    );
  }
}
