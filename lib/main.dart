import 'package:flutter/material.dart';
import 'package:flutter_app_splitthebill/views/home_view.dart';
import 'package:flutter_app_splitthebill/views/qrcode_view.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeView(),
        '/qrcode': (context) => QrcodeView(),
      },
    );
  }
}
