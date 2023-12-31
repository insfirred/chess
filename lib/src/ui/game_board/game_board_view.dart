import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/tile.dart';
import 'game_board_view_model.dart';

class GameBoardView extends ConsumerWidget {
  const GameBoardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(
      gameBoardViewModelProvider.select((_) => _.board),
    );
    final gameStatus =
        ref.watch(gameBoardViewModelProvider.select((_) => _.gameStatus));
    final selectedIndex = ref.watch(
      gameBoardViewModelProvider.select((_) => _.selectedIndex),
    );
    final validMoves = ref.watch(
      gameBoardViewModelProvider.select((_) => _.validMovesOfSelectedPiece),
    );

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[600],
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: screenWidth > 500 ? 500 : screenWidth,
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'C H E S S',
                      style: GoogleFonts.poppins(
                        fontSize: 38,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 8 * 8,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                    },
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
