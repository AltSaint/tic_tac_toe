import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:svg_icon/svg_icon.dart';
import 'package:tic_tac_toe/custom_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

bool ohTurn = true;
const myTextstyle = TextStyle(color: Colors.white, fontSize: 30);
int ohScore = 0;
int exScore = 0;
int filledBoxes = 0;

var myNewFont = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
var myNewFontWhite = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));
var myNewFontWhiteGrid = GoogleFonts.pressStart2p(
    textStyle: TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 40));

void changeTextStyle() {}

List<String> displayMark = [
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
];

class _HomeScreenState extends State<HomeScreen> {
  void _tapped(int index) {
    setState(() {
      if (ohTurn && displayMark[index] == '') {
        displayMark[index] = 'o';
        filledBoxes += 1;
      } else if (!ohTurn && displayMark[index] == '') {
        displayMark[index] = 'x';
        filledBoxes += 1;
      }

      ohTurn = !ohTurn;
      _checkWinner();
    });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text(
              'Winner is: ' + winner,
              style: myNewFontWhite,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Play Again',
                  style: myNewFontWhite,
                ),
                onPressed: () {
                  _clearBord();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });

    if (winner == 'o') {
      ohScore += 1;
    } else if (winner == 'x') {
      exScore += 1;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey.shade900,
            title: Text(
              'Draw:',
              style: myNewFontWhite,
            ),
            actions: [
              TextButton(
                child: Text(
                  'Play Again',
                  style: myNewFontWhite,
                ),
                onPressed: () {
                  _clearBord();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _clearBord() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayMark[i] = '';
      }
    });

    filledBoxes = 0;
  }

  void _checkWinner() {
    if (displayMark[0] == displayMark[1] &&
        displayMark[0] == displayMark[2] &&
        displayMark[0] != '') {
      _showWinDialog(displayMark[0]);
    }

    // checks 2nd row
    if (displayMark[3] == displayMark[4] &&
        displayMark[3] == displayMark[5] &&
        displayMark[3] != '') {
      _showWinDialog(displayMark[3]);
    }

    // checks 3rd row
    if (displayMark[6] == displayMark[7] &&
        displayMark[6] == displayMark[8] &&
        displayMark[6] != '') {
      _showWinDialog(displayMark[6]);
    }

    // checks 1st column
    if (displayMark[0] == displayMark[3] &&
        displayMark[0] == displayMark[6] &&
        displayMark[0] != '') {
      _showWinDialog(displayMark[0]);
    }

    // checks 2nd column
    if (displayMark[1] == displayMark[4] &&
        displayMark[1] == displayMark[7] &&
        displayMark[1] != '') {
      _showWinDialog(displayMark[1]);
    }

    // checks 3rd column
    if (displayMark[2] == displayMark[5] &&
        displayMark[2] == displayMark[8] &&
        displayMark[2] != '') {
      _showWinDialog(displayMark[2]);
    }

    // checks diagonal
    if (displayMark[6] == displayMark[4] &&
        displayMark[6] == displayMark[2] &&
        displayMark[6] != '') {
      _showWinDialog(displayMark[6]);
    }

    // checks diagonal
    if (displayMark[0] == displayMark[4] &&
        displayMark[0] == displayMark[8] &&
        displayMark[0] != '') {
      _showWinDialog(displayMark[0]);
    } else if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              CustomIcons.backarrow,
              color: Colors.white,
              size: 30,
            )),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Player x', style: myNewFontWhite),
                        Text(exScore.toString(), style: myNewFontWhite),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Player o', style: myNewFontWhite),
                        Text(ohScore.toString(), style: myNewFontWhite),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.only(top: 72),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/images/tic_tac_toe_logo.png',
                    color: Colors.white,
                    fit: BoxFit.scaleDown,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          _tapped(index);
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Center(
                            child: Text(displayMark[index],
                                style: myNewFontWhiteGrid),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
