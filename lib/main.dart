import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learnify/res/ScoreStoring.dart';
import 'package:learnify/screens/HomeScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ViewViewModel/AlphabetModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final st = StoreScore();
  st.initialise();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AlphabetProvider()),
        ],
        child: MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomeScreen()));
  }
}
