import 'package:flutter/material.dart';
import 'package:galaxy_tracker/login_page.dart';
import 'package:galaxy_tracker/histories_page.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Galaxy Tracker',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/histories': (context) => HistoriesPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.redAccent[200],
        accentColor: Color(0xff45748C),
        fontFamily: "Roboto",
        buttonColor: Colors.redAccent[200],
      ),
    );
  }
}
