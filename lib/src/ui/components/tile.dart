import 'package:chess/src/ui/game_board/game_board_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/piece.dart';

class Tile extends ConsumerWidget {
  const Tile({
    super.key,
    required this.isWhite,
    this.piece,
    required this.index,
  });

  final bool isWhite;
  final Piece? piece;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(
      gameBoardViewModelProvider.select((_) => _.selectedIndex),
    );
    final board = ref.watch(gameBoardViewModelProvider.select((_) => _.board));
    final validMoves = ref.watch(
        gameBoardViewModelProvider.select((_) => _.validMovesOfSelectedPiece));

    Color? tileColor =
        selectedIndex == index && board[index ~/ 8][index % 8] != null
            ? Colors.green
            : isWhite
                ? Colors.grey[500]
                : Colors.grey[800];

    int row = index ~/ 8;
    int col = index % 8;

    bool isValidMove = false;
    for (var pair in validMoves) {
      if (row == pair.i && col == pair.j) isValidMove = true;
    }

    return GestureDetector(
      onTap: () =>
          ref.read(gameBoardViewModelProvider.notifier).tileTapped(index),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: tileColor,
            child: piece != null
                ? Center(
                    child: Image.asset(
                      'assets/images/${piece!.type.name}.png',
                      color: piece!.isWhite ? Colors.white : Colors.black,
                      width: 30,
                    ),
                  )
                : null,
          ),
          if (isValidMove) ...[
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
