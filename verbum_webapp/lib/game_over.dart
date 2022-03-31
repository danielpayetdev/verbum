import 'package:flutter/material.dart';
import 'package:verbum_webapp/game/game_state.dart';
import 'package:verbum_webapp/grille.dart';

class GameOver extends StatelessWidget {
  final GameState game;
  const GameOver({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Perdu pour aujourd'hui ! 😢",
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text("Le mot du jour était :"),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  game.word,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Grille(wordGrid: game.wordGrid),
          ),
        ],
      ),
    );
  }
}
