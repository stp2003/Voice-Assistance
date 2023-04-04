import 'package:chat_gpt/constants/colors.dart'
import 'package:chat_gpt/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Chat Gpt',
      theme: ThemeData.dark(useMaterial3: true).copyWith(
        scaffoldBackgroundColor: bgColor,
        appBarTheme: const AppBarTheme(color: appBarColor),
      ),
      home: const HomeScreen(),
    );
  }
}
