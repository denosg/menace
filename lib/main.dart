import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/home_screen.dart';
import './providers/video_provider.dart';

// God is watching me and he is not pleased

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
          ),
          scaffoldBackgroundColor: Colors.black,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
