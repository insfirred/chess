import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../model/pair.dart';
import '../../model/piece.dart';
import '../../utils/check_bound.dart';

part 'game_board_view_model.freezed.dart';

final gameBoardViewModelProvider =
    StateNotifierProvider.autoDispose<GameBoardViewModel, GameBoardViewState>(
  (ref) => GameBoardViewModel(),
);

class GameBoardViewModel extends StateNotifier<GameBoardViewState> {
  GameBoardViewModel() : super(const GameBoardViewState()) {
    _initializeBoard();
  }

  tileTapped(int index) {
    int i = index ~/ 8;
    int j = index % 8;

    switch (state.gameStatus) {
      case GameStatus.whiteToPlay:
        if (state.board[i][j] != null && state.board[i][j]!.isWhite) {
          state = state.copyWith(
            selectedIndex: index,
            gameStatus: GameStatus.whiteSelectedAPiece,
          );
        }
        break;

      case GameStatus.whiteSelectedAPiece:
        bool isTappedTileAValidMove = false;
        for (var pair in state.validMovesOfSelectedPiece) {
          if (pair.i == i && pair.j == j) {
            isTappedTileAValidMove = true;
            break;
          }
        }
        if (isTappedTileAValidMove) {
          // storing old positions and piece
          int prevI = state.selectedIndex! ~/ 8;
          int prevJ = state.selectedIndex! % 8;
          Piece prevPiece = state.board[prevI][prevJ]!;

          List<List<Piece?>> newBoard = state.board;
          // clearing old position
          newBoard[state.selectedIndex! ~/ 8][state.selectedIndex! % 8] = null;
          newBoard[i][j] = prevPiece;
          state = state.copyWith(
            selectedIndex: null,
            gameStatus: GameStatus.blackToPlay,
            validMovesOfSelectedPiece: [],
          );
        } else {
          if (state.board[i][j] == null) {
            state = state.copyWith(
              selectedIndex: null,
              gameStatus: GameStatus.whiteToPlay,
            );
          } else if (state.board[i][j]!.isWhite) {
            state = state.copyWith(
              selectedIndex: index,
              gameStatus: GameStatus.whiteSelectedAPiece,
            );
          } else if (!(state.board[i][j]!.isWhite)) {
            state = state.copyWith(
              selectedIndex: null,
              gameStatus: GameStatus.whiteToPlay,
            );
          }
        }
        break;

      case GameStatus.blackToPlay:
        if (state.board[i][j] != null && !(state.board[i][j]!.isWhite)) {
          state = state.copyWith(
            selectedIndex: index,
            gameStatus: GameStatus.blackSelectedAPiece,
          );
        }
        break;

      case GameStatus.blackSelectedAPiece:
        bool isTappedTileAValidMove = false;
        for (var pair in state.validMovesOfSelectedPiece) {
          if (pair.i == i && pair.j == j) {
            isTappedTileAValidMove = true;
            break;
          }
        }
        if (isTappedTileAValidMove) {
          // storing old positions and piece
          int prevI = state.selectedIndex! ~/ 8;
          int prevJ = state.selectedIndex! % 8;
          Piece prevPiece = state.board[prevI][prevJ]!;

          List<List<Piece?>> newBoard = state.board;
          // clearing old position
          newBoard[state.selectedIndex! ~/ 8][state.selectedIndex! % 8] = null;
          newBoard[i][j] = prevPiece;
          state = state.copyWith(
            selectedIndex: null,
            gameStatus: GameStatus.whiteToPlay,
            validMovesOfSelectedPiece: [],
          );
        } else {
          if (state.board[i][j] == null) {
            state = state.copyWith(
              selectedIndex: null,
              gameStatus: GameStatus.blackToPlay,
            );
          } else if (!(state.board[i][j]!.isWhite)) {
            state = state.copyWith(
              selectedIndex: index,
              gameStatus: GameStatus.blackSelectedAPiece,
            );
          } else if ((state.board[i][j]!.isWhite)) {
            state = state.copyWith(
              selectedIndex: null,
              gameStatus: GameStatus.blackToPlay,
            );
          }
        }
        break;
    }
    _generateValidMoves();
  }

  _generateValidMoves() {
    if (state.selectedIndex != null) {
      Piece selectedPiece =
          state.board[state.selectedIndex! ~/ 8][state.selectedIndex! % 8]!;

      int direction = selectedPiece.isWhite ? -1 : 1;
      List<Pair<int, int>> validMoves = [];

      int i = state.selectedIndex! ~/ 8;
      int j = state.selectedIndex! % 8;

      switch (selectedPiece.type) {
        case PieceType.pawn:
          if (inBoard(i + direction, j) &&
              state.board[i + direction][j] == null) {
            validMoves.add(Pair(i + direction, j));
          }
          if (inBoard(i + (2 * direction), j) &&
              state.board[i + (2 * direction)][j] == null &&
              (i == 1 || i == 6) &&
              (state.board[i + direction][j] == null)) {
            validMoves.add(Pair(i + (2 * direction), j));
          }
          if (selectedPiece.isWhite) {
            if (inBoard(i - 1, j - 1) &&
                state.board[i - 1][j - 1] != null &&
                !(state.board[i - 1][j - 1]!.isWhite)) {
              validMoves.add(Pair(i - 1, j - 1));
            }
            if (inBoard(i - 1, j + 1) &&
                state.board[i - 1][j + 1] != null &&
                !(state.board[i - 1][j + 1]!.isWhite)) {
              validMoves.add(Pair(i - 1, j + 1));
            }
          } else {
            if (inBoard(i + 1, j - 1) &&
                state.board[i + 1][j - 1] != null &&
                (state.board[i + 1][j - 1]!.isWhite)) {
              validMoves.add(Pair(i + 1, j - 1));
            }
            if (inBoard(i + 1, j + 1) &&
                state.board[i + 1][j + 1] != null &&
                (state.board[i + 1][j + 1]!.isWhite)) {
              validMoves.add(Pair(i + 1, j + 1));
            }
          }
          break;

        case PieceType.rook:
          int k = i - 1;
          while (true) {
            if (k < 0 || state.board[k][j] != null) {
              if (k >= 0) {
                if (state.board[k][j]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(k, j));
                }
              }
              break;
            }
            validMoves.add(Pair(k, j));
            k--;
          }
          k = i + 1;
          while (true) {
            if (k >= 8 || state.board[k][j] != null) {
              if (k < 8) {
                if (state.board[k][j]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(k, j));
                }
              }
              break;
            }
            validMoves.add(Pair(k, j));
            k++;
          }
          k = j - 1;
          while (true) {
            if (k < 0 || state.board[i][k] != null) {
              if (k >= 0) {
                if (state.board[i][k]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(i, k));
                }
              }
              break;
            }
            validMoves.add(Pair(i, k));
            k--;
          }
          k = j + 1;
          while (true) {
            if (k >= 8 || state.board[i][k] != null) {
              if (k < 8) {
                if (state.board[i][k]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(i, k));
                }
              }
              break;
            }
            validMoves.add(Pair(i, k));
            k++;
          }
          break;

        case PieceType.knight:
          if (inBoard(i - 2, j + 1) &&
              (state.board[i - 2][j + 1] == null ||
                  state.board[i - 2][j + 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 2, j + 1));
          }
          if (inBoard(i - 2, j - 1) &&
              (state.board[i - 2][j - 1] == null ||
                  state.board[i - 2][j - 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 2, j - 1));
          }
          if (inBoard(i - 1, j + 2) &&
              (state.board[i - 1][j + 2] == null ||
                  state.board[i - 1][j + 2]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 1, j + 2));
          }
          if (inBoard(i - 1, j - 2) &&
              (state.board[i - 1][j - 2] == null ||
                  state.board[i - 1][j - 2]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 1, j - 2));
          }
          if (inBoard(i + 2, j + 1) &&
              (state.board[i + 2][j + 1] == null ||
                  state.board[i + 2][j + 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 2, j + 1));
          }
          if (inBoard(i + 2, j - 1) &&
              (state.board[i + 2][j - 1] == null ||
                  state.board[i + 2][j - 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 2, j - 1));
          }
          if (inBoard(i + 1, j + 2) &&
              (state.board[i + 1][j + 2] == null ||
                  state.board[i + 1][j + 2]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 1, j + 2));
          }
          if (inBoard(i + 1, j - 2) &&
              (state.board[i + 1][j - 2] == null ||
                  state.board[i + 1][j - 2]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 1, j - 2));
          }
          break;

        case PieceType.bishop:
          int p = i - 1;
          int q = j - 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p--;
            q--;
          }
          p = i - 1;
          q = j + 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p--;
            q++;
          }
          p = i + 1;
          q = j - 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p++;
            q--;
          }
          p = i + 1;
          q = j + 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p++;
            q++;
          }
          break;

        case PieceType.queen:
          int p = i - 1;
          int q = j - 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p--;
            q--;
          }
          p = i - 1;
          q = j + 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p--;
            q++;
          }
          p = i + 1;
          q = j - 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p++;
            q--;
          }
          p = i + 1;
          q = j + 1;
          while (true) {
            if (!inBoard(p, q) || state.board[p][q] != null) {
              if (inBoard(p, q)) {
                if (state.board[p][q]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(p, q));
                }
              }
              break;
            }
            validMoves.add(Pair(p, q));
            p++;
            q++;
          }

          int k = i - 1;
          while (true) {
            if (k < 0 || state.board[k][j] != null) {
              if (k >= 0) {
                if (state.board[k][j]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(k, j));
                }
              }
              break;
            }
            validMoves.add(Pair(k, j));
            k--;
          }
          k = i + 1;
          while (true) {
            if (k >= 8 || state.board[k][j] != null) {
              if (k < 8) {
                if (state.board[k][j]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(k, j));
                }
              }
              break;
            }
            validMoves.add(Pair(k, j));
            k++;
          }
          k = j - 1;
          while (true) {
            if (k < 0 || state.board[i][k] != null) {
              if (k >= 0) {
                if (state.board[i][k]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(i, k));
                }
              }
              break;
            }
            validMoves.add(Pair(i, k));
            k--;
          }
          k = j + 1;
          while (true) {
            if (k >= 8 || state.board[i][k] != null) {
              if (k < 8) {
                if (state.board[i][k]!.isWhite != selectedPiece.isWhite) {
                  validMoves.add(Pair(i, k));
                }
              }
              break;
            }
            validMoves.add(Pair(i, k));
            k++;
          }
          break;

        case PieceType.king:
          if (inBoard(i + 1, j + 1) &&
              (state.board[i + 1][j + 1] == null ||
                  state.board[i + 1][j + 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 1, j + 1));
          }
          if (inBoard(i + 1, j) &&
              (state.board[i + 1][j] == null ||
                  state.board[i + 1][j]!.isWhite != selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 1, j));
          }
          if (inBoard(i + 1, j - 1) &&
              (state.board[i + 1][j - 1] == null ||
                  state.board[i + 1][j - 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i + 1, j - 1));
          }
          if (inBoard(i - 1, j + 1) &&
              (state.board[i - 1][j + 1] == null ||
                  state.board[i - 1][j + 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 1, j + 1));
          }
          if (inBoard(i - 1, j) &&
              (state.board[i - 1][j] == null ||
                  state.board[i - 1][j]!.isWhite != selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 1, j));
          }
          if (inBoard(i - 1, j - 1) &&
              (state.board[i - 1][j - 1] == null ||
                  state.board[i - 1][j - 1]!.isWhite !=
                      selectedPiece.isWhite)) {
            validMoves.add(Pair(i - 1, j - 1));
          }
          if (inBoard(i, j + 1) &&
              (state.board[i][j + 1] == null ||
                  state.board[i][j + 1]!.isWhite != selectedPiece.isWhite)) {
            validMoves.add(Pair(i, j + 1));
          }
          if (inBoard(i, j - 1) &&
              (state.board[i][j - 1] == null ||
                  state.board[i][j - 1]!.isWhite != selectedPiece.isWhite)) {
            validMoves.add(Pair(i, j - 1));
          }
          break;
      }
      state = state.copyWith(validMovesOfSelectedPiece: validMoves);
    } else {
      state = state.copyWith(validMovesOfSelectedPiece: []);
    }
  }

  bool isInBoard(int i, int j) {
    return i >= 0 && i < 8 && j >= 0 && j < 8;
  }

  _initializeBoard() {
    List<List<Piece?>> newBoard =
        List.generate(8, (index) => List.filled(8, null));

    // DEFAULT_BOARD
    // pawns
    for (var i = 0; i < 8; i++) {
      newBoard[1][i] = Piece(isWhite: false, type: PieceType.pawn);
    }
    for (var i = 0; i < 8; i++) {
      newBoard[6][i] = Piece(isWhite: true, type: PieceType.pawn);
    }

    // rooks
    newBoard[0][0] = Piece(isWhite: false, type: PieceType.rook);
    newBoard[0][7] = Piece(isWhite: false, type: PieceType.rook);
    newBoard[7][0] = Piece(isWhite: true, type: PieceType.rook);
    newBoard[7][7] = Piece(isWhite: true, type: PieceType.rook);

    // bishops
    newBoard[0][2] = Piece(isWhite: false, type: PieceType.bishop);
    newBoard[0][5] = Piece(isWhite: false, type: PieceType.bishop);
    newBoard[7][2] = Piece(isWhite: true, type: PieceType.bishop);
    newBoard[7][5] = Piece(isWhite: true, type: PieceType.bishop);

    // knights
    newBoard[0][1] = Piece(isWhite: false, type: PieceType.knight);
    newBoard[0][6] = Piece(isWhite: false, type: PieceType.knight);
    newBoard[7][1] = Piece(isWhite: true, type: PieceType.knight);
    newBoard[7][6] = Piece(isWhite: true, type: PieceType.knight);

    // queens
    newBoard[0][4] = Piece(isWhite: false, type: PieceType.queen);
    newBoard[7][3] = Piece(isWhite: true, type: PieceType.queen);

    // kings
    newBoard[0][3] = Piece(isWhite: false, type: PieceType.king);
    newBoard[7][4] = Piece(isWhite: true, type: PieceType.king);

    // TEST_BOARD
    // newBoard[3][4] = Piece(isWhite: false, type: PieceType.queen);
    // newBoard[4][4] = Piece(isWhite: true, type: PieceType.queen);
    // newBoard[1][0] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][1] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][2] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][3] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][4] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][5] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][6] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[1][7] = Piece(isWhite: false, type: PieceType.pawn);
    // newBoard[6][0] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][1] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][2] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][3] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][4] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][5] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][6] = Piece(isWhite: true, type: PieceType.pawn);
    // newBoard[6][7] = Piece(isWhite: true, type: PieceType.pawn);

    state = state.copyWith(board: newBoard);
  }
}

@freezed
class GameBoardViewState with _$GameBoardViewState {
  const factory GameBoardViewState({
    @Default([]) List<List<Piece?>> board,
    int? selectedIndex,
    @Default(GameStatus.whiteToPlay) GameStatus gameStatus,
    @Default([]) List<Pair<int, int>> validMovesOfSelectedPiece,
  }) = _GameBoardViewState;
}

enum GameStatus {
  whiteToPlay,
  blackToPlay,
  whiteSelectedAPiece,
  blackSelectedAPiece
}
