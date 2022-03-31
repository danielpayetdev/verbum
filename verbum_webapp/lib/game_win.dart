import 'package:flutter/material.dart';
import 'package:verbum_webapp/game/game_state.dart';
import 'package:verbum_webapp/grille.dart';

class GameWin extends StatelessWidget {
  final GameState game;
  const GameWin({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Bravo ! 🎉",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tu as trouvé en ${game.currentRow + 1} mot${game.currentRow == 0 ? '' : 's'} !"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
            ],
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
