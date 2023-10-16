class Piece {
  bool isWhite;
  PieceType type;

  Piece({required this.isWhite, required this.type});
}

enum PieceType {
  pawn,
  rook,
  knight,
  bishop,
  queen,
  king,
}
