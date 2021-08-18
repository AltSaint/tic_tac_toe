import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.grey.shade900,
              elevation: 0,
              brightness: Brightness.dark)),
      home: IntroScreen(),
    );
  }
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: TextStyle(
    color: Colors.white,
  ));

  @override
  Widget build(BuildContext context) {
    final whiteColor = Colors.white;
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Text(
                "TIC TAC TOE",
                style: myNewFontWhite.copyWith(fontSize: 30),
              ),
            ),
            Container(
              child: AvatarGlow(
                endRadius: 140,
                duration: Duration(seconds: 2),
                glowColor: whiteColor,
                repeat: true,
                repeatPauseDuration: Duration(seconds: 1),
                startDelay: Duration(seconds: 1),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        style: BorderStyle.none,
                      ),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[900],
                    child: Container(
                      child: Image.asset(
                        'assets/images/tic_tac_toe_logo.png',
                        color: whiteColor,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                    radius: 80.0,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.all(30),
                    color: whiteColor,
                    child: Center(
                      child: Text(
                        'PLAY GAME',
                        style: myNewFont,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
