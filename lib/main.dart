import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp();

  MyApp.forDesignTime();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Random Numbers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Simple Rnadom Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentSelectedDice = 6;
  double _diceCount = 1;
  double _extra = 0;
  List<int> _rolledDices = [];
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: [
              _generateDiceButton('assets/images/d4.png', 4),
              _generateDiceButton(
                  'assets/images/perspective-dice-six-faces-six.png', 6),
              _generateDiceButton(
                  'assets/images/dice-eight-faces-eight.png', 8),
              _generateDiceButton('assets/images/d10.png', 10),
              _generateDiceButton('assets/images/d12.png', 12),
              _generateDiceButton(
                  'assets/images/dice-twenty-faces-twenty.png', 20),
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: 8, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Text('Dices: '),
                  Text(" ${_diceCount.toInt()}")
                ]),
              )),
          Slider(
            value: _diceCount,
            min: 1,
            max: 20,
            divisions: 19,
            onChanged: (newDiceCount) {
              setState(() => _diceCount = newDiceCount);
            },
            label: "${_diceCount.toInt()}",
          ),
          Padding(
              padding: EdgeInsets.only(left: 8, top: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Row(
                    children: [Text('Extra: '), Text(" ${_extra.toInt()}")]),
              )),
          Slider(
            value: _extra,
            min: -20,
            max: 20,
            divisions: 40,
            onChanged: (newExtra) {
              setState(() => _extra = newExtra);
            },
            label: "${_extra.toInt()}",
          ),
          Expanded(
            child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: Text(
                          "${_rolledDices.join(", ") + " + " + _extra.toInt().toString()}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )),
                    Expanded(
                        flex: 5,
                        child: Text(
                          "$_total",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 64),
                        )),
                  ],
                )),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                onPressed: _rollDices,
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("ROLL"),
              ),
              RaisedButton(
                onPressed: _addDiceRolls,
                textColor: Colors.white,
                color: Colors.blue,
                child: Text("ADD"),
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector _generateDiceButton(String diceImagePath, int diceIndex) {
    return new GestureDetector(
        onTap: () {
          setState(() {
            _currentSelectedDice = diceIndex;
          });
        },
        child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _currentSelectedDice == diceIndex ? Colors.blue : null,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image(
                image: AssetImage(diceImagePath),
              ),
            )));
  }

  void _rollDices() {
    setState(() {
      _rolledDices = _getRandomRolls(_diceCount.toInt(), _currentSelectedDice);
    });
    _updateTotal();
  }

  void _addDiceRolls() {
    setState(() {
      _rolledDices
          .addAll(_getRandomRolls(_diceCount.toInt(), _currentSelectedDice));
    });
    _updateTotal();
  }

  List<int> _getRandomRolls(int numbersQuantity, int maxNumber) {
    Random random = new Random();
    var generatedRandoms = <int>[];
    for (int i = 0; i < numbersQuantity; i++) {
      generatedRandoms.add(random.nextInt(maxNumber) + 1);
    }
    return generatedRandoms;
  }

  void _updateTotal() {
    setState(() {
      _total = _rolledDices.reduce((a, b) => a + b) + _extra.toInt();
    });
  }
}
