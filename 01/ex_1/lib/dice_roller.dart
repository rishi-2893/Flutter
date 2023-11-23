// This need not to be added to the yaml file as it ships with dart
import 'dart:math';

import 'package:flutter/material.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  // Similar to what build() is used for stateless widgets
  // createState() is used for stateful widgets
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }
}

// Under score at the start tells dart that this is a private class
// i.e., cannot be used outside this file
class _DiceRollerState extends State<DiceRoller> {
  var activeDiceImage = 'assets/images/dice-1.png';

  final randomizer = Random();


  void rollDice() {

    // ----------Wrong approach-----------
    // Below approach creates a new Random() object every time you click button
    // Instead create Random() object outside this event handler
    // var diceRoll = Random().nextInt(6) + 1; // 1 to 6
    
    // ----------Correct approach-----------
    var diceRoll = randomizer.nextInt(6) + 1 ; // 1 to 6

    
    // Simply changing the value of activeDiceImage will not update the UI
    // UI gets updated solely when build() is called
    // setState() is used to update the UI as it calls build()
    setState(() {
      activeDiceImage = 'assets/images/dice-$diceRoll.png';
    });
  }

  @override
  Widget build(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(activeDiceImage, width: 200),
        const SizedBox(height: 20), // Alternative to adding padding
        TextButton(
          onPressed: rollDice,
          style: TextButton.styleFrom(
            // padding: const EdgeInsets.only(
            //   top: 20,
            // ),
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontSize: 28,
            ),
          ),
          child: const Text('Roll Dice'),
        )
      ],
    );
  }
}
