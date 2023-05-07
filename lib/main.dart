import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './providers/video_provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => VideoProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            textTheme:
                const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.orange,
              secondary: Colors.white,
            )),
        home: HomeScreen(),
      ),
    );
  }
}
