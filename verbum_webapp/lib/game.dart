import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbum_webapp/game/game.provider.dart';
import 'package:verbum_webapp/game_win.dart';
import 'package:verbum_webapp/game_over.dart';
import 'package:verbum_webapp/game_ui/keyboard.dart';
import 'package:verbum_webapp/grille.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, game, child) {
        if (game.isOver && game.isWon) {
          return GameWin(stats: game.getStatistique());
        } else if (game.isOver && !game.isWon) {
          return GameOver(stats: game.getStatistique());
        } else {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Grille(wordGrid: game.wordGrid),
              ),
              Keyboard(
                onKeyTap: (String letter) {
                  game.typeLetter(letter);
                },
                onBackspaceTap: () => game.deleteLetter(),
                onSubmitTap: () => game.submit(),
              ),
            ],
          );
        }
      },
    );
  }
}
