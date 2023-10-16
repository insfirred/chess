import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/tile.dart';
import 'game_board_view_model.dart';

class GameBoardView extends ConsumerWidget {
  const GameBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(gameBoardViewModelProvider.select((_) => _.board));
    final gameStatus =
        ref.watch(gameBoardViewModelProvider.select((_) => _.gameStatus));
    final selectedIndex =
        ref.watch(gameBoardViewModelProvider.select((_) => _.selectedIndex));
    final validMoves = ref.watch(
        gameBoardViewModelProvider.select((_) => _.validMovesOfSelectedPiece));

    // print('loop starting');
    // for (var element in validMoves) {
    //   print("${element.i} ${element.j}");
    // }
    // print(validMoves.length);

    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: Text('C H E S S')),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  itemCount: 8 * 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 8;
                    int col = index % 8;

                    return Center(
                      child: Tile(
                        isWhite: (row + col) % 2 == 1,
                        piece: board[row][col],
                        index: index,
                      ),
                    );
                  }),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(gameStatus.name),
                  Text(selectedIndex.toString()),
                  Text(
                    "${validMoves.map((pair) => pair.i).toList()} ${validMoves.map((pair) => pair.j).toList()}",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
