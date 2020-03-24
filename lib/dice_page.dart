import 'dart:math';

import 'package:flutter/material.dart';
import 'package:simple_random_numbers/dice_button.dart';

class DicePage extends StatefulWidget {
  DicePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int _currentSelectedDice = 6;
  double _diceCount = 1;
  double _extra = 0;
  List<int> _rolledDices = [];
  int _total = 0;

  void _setSelectedDice(int diceIndex) {
    setState(() {
      _currentSelectedDice = diceIndex;
    });
  }

  DiceButton _createDiceButton(Map<String, Object> diceInfo) {
    return new DiceButton(_currentSelectedDice, diceInfo['diceIndex'],
        diceInfo['diceImagePath'], _setSelectedDice);
  }

  @override
  Widget build(BuildContext context) {
    const dicesInfo = [
      {'diceIndex': 4, 'diceImagePath': 'assets/images/d4.png'},
      {
        'diceIndex': 6,
        'diceImagePath': 'assets/images/perspective-dice-six-faces-six.png'
      },
      {
        'diceIndex': 8,
        'diceImagePath': 'assets/images/dice-eight-faces-eight.png'
      },
      {'diceIndex': 10, 'diceImagePath': 'assets/images/d12.png'},
      {'diceIndex': 12, 'diceImagePath': 'assets/images/d10.png'},
      {
        'diceIndex': 20,
        'diceImagePath': 'assets/images/dice-twenty-faces-twenty.png'
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 3,
            children: dicesInfo.map(_createDiceButton).toList(),
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
