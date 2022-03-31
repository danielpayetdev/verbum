import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:verbum_webapp/erreur_message.dart';
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
      builder: (context, gameProvider, child) {
        if (gameProvider.game!.isOver && gameProvider.game!.isWon) {
          return GameWin(game: gameProvider.getState());
        } else if (gameProvider.game!.isOver && !gameProvider.game!.isWon) {
          return GameOver(game: gameProvider.getState());
        } else {
          return Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("en ${gameProvider.game!.word.length} lettres"),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Grille(wordGrid: gameProvider.game!.wordGrid),
                      ),
                      const ErrorMessage(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: Keyboard(
                  onKeyTap: (String letter) {
                    gameProvider.typeLetter(letter);
                  },
                  onBackspaceTap: () => gameProvider.deleteLetter(),
                  onSubmitTap: () => gameProvider.submit(),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
