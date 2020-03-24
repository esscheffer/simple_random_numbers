import 'package:flutter/material.dart';

class DiceButton extends StatelessWidget {
  final String _diceImagePath;
  final int _diceIndex;
  final int _currentSelectedDice;
  final Function _onTapFunction;

  DiceButton(this._currentSelectedDice, this._diceIndex, this._diceImagePath,
      this._onTapFunction);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => _onTapFunction(_diceIndex),
        child: Container(
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: _currentSelectedDice == _diceIndex ? Colors.blue : null,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image(
                image: AssetImage(_diceImagePath),
              ),
            )));
  }
}
