import 'package:flutter/material.dart';
import 'package:restaurant_frontend/app.dart';
import 'package:restaurant_frontend/utils/local_storage/storage_utility.dart';

int? initScreen;
Future<void> main() async {
  //TODO: Add Widgets
  WidgetsFlutterBinding.ensureInitialized();
  //TODO: Init Local Storage
  // initScreen = await TLocalStorage.getInt('initScreen') ?? 0;
  // bool rememberMe = await TLocalStorage.getBool('rememberMe') ?? false;
  // await TLocalStorage.saveInt('initScreen', 1);
  // print('initScreen $initScreen');
  //TODO: Await Native Splash Screen
  //TODO: Initialize Firebase
  //TODO: Initiliaze Authentication
  runApp(const App());
}
