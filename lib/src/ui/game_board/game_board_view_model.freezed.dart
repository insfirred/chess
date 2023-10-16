// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_board_view_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$GameBoardViewState {
  List<List<Piece?>> get board => throw _privateConstructorUsedError;
  int? get selectedIndex => throw _privateConstructorUsedError;
  GameStatus get gameStatus => throw _privateConstructorUsedError;
  List<Pair<int, int>> get validMovesOfSelectedPiece =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $GameBoardViewStateCopyWith<GameBoardViewState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameBoardViewStateCopyWith<$Res> {
  factory $GameBoardViewStateCopyWith(
          GameBoardViewState value, $Res Function(GameBoardViewState) then) =
      _$GameBoardViewStateCopyWithImpl<$Res, GameBoardViewState>;
  @useResult
  $Res call(
      {List<List<Piece?>> board,
      int? selectedIndex,
      GameStatus gameStatus,
      List<Pair<int, int>> validMovesOfSelectedPiece});
}

/// @nodoc
class _$GameBoardViewStateCopyWithImpl<$Res, $Val extends GameBoardViewState>
    implements $GameBoardViewStateCopyWith<$Res> {
  _$GameBoardViewStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? selectedIndex = freezed,
    Object? gameStatus = null,
    Object? validMovesOfSelectedPiece = null,
  }) {
    return _then(_value.copyWith(
      board: null == board
          ? _value.board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Piece?>>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      validMovesOfSelectedPiece: null == validMovesOfSelectedPiece
          ? _value.validMovesOfSelectedPiece
          : validMovesOfSelectedPiece // ignore: cast_nullable_to_non_nullable
              as List<Pair<int, int>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameBoardViewStateImplCopyWith<$Res>
    implements $GameBoardViewStateCopyWith<$Res> {
  factory _$$GameBoardViewStateImplCopyWith(_$GameBoardViewStateImpl value,
          $Res Function(_$GameBoardViewStateImpl) then) =
      __$$GameBoardViewStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<List<Piece?>> board,
      int? selectedIndex,
      GameStatus gameStatus,
      List<Pair<int, int>> validMovesOfSelectedPiece});
}

/// @nodoc
class __$$GameBoardViewStateImplCopyWithImpl<$Res>
    extends _$GameBoardViewStateCopyWithImpl<$Res, _$GameBoardViewStateImpl>
    implements _$$GameBoardViewStateImplCopyWith<$Res> {
  __$$GameBoardViewStateImplCopyWithImpl(_$GameBoardViewStateImpl _value,
      $Res Function(_$GameBoardViewStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? board = null,
    Object? selectedIndex = freezed,
    Object? gameStatus = null,
    Object? validMovesOfSelectedPiece = null,
  }) {
    return _then(_$GameBoardViewStateImpl(
      board: null == board
          ? _value._board
          : board // ignore: cast_nullable_to_non_nullable
              as List<List<Piece?>>,
      selectedIndex: freezed == selectedIndex
          ? _value.selectedIndex
          : selectedIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      gameStatus: null == gameStatus
          ? _value.gameStatus
          : gameStatus // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      validMovesOfSelectedPiece: null == validMovesOfSelectedPiece
          ? _value._validMovesOfSelectedPiece
          : validMovesOfSelectedPiece // ignore: cast_nullable_to_non_nullable
              as List<Pair<int, int>>,
    ));
  }
}

/// @nodoc

class _$GameBoardViewStateImpl implements _GameBoardViewState {
  const _$GameBoardViewStateImpl(
      {final List<List<Piece?>> board = const [],
      this.selectedIndex,
      this.gameStatus = GameStatus.whiteToPlay,
      final List<Pair<int, int>> validMovesOfSelectedPiece = const []})
      : _board = board,
        _validMovesOfSelectedPiece = validMovesOfSelectedPiece;

  final List<List<Piece?>> _board;
  @override
  @JsonKey()
  List<List<Piece?>> get board {
    if (_board is EqualUnmodifiableListView) return _board;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_board);
  }

  @override
  final int? selectedIndex;
  @override
  @JsonKey()
  final GameStatus gameStatus;
  final List<Pair<int, int>> _validMovesOfSelectedPiece;
  @override
  @JsonKey()
  List<Pair<int, int>> get validMovesOfSelectedPiece {
    if (_validMovesOfSelectedPiece is EqualUnmodifiableListView)
      return _validMovesOfSelectedPiece;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_validMovesOfSelectedPiece);
  }

  @override
  String toString() {
    return 'GameBoardViewState(board: $board, selectedIndex: $selectedIndex, gameStatus: $gameStatus, validMovesOfSelectedPiece: $validMovesOfSelectedPiece)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameBoardViewStateImpl &&
            const DeepCollectionEquality().equals(other._board, _board) &&
            (identical(other.selectedIndex, selectedIndex) ||
                other.selectedIndex == selectedIndex) &&
            (identical(other.gameStatus, gameStatus) ||
                other.gameStatus == gameStatus) &&
            const DeepCollectionEquality().equals(
                other._validMovesOfSelectedPiece, _validMovesOfSelectedPiece));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_board),
      selectedIndex,
      gameStatus,
      const DeepCollectionEquality().hash(_validMovesOfSelectedPiece));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameBoardViewStateImplCopyWith<_$GameBoardViewStateImpl> get copyWith =>
      __$$GameBoardViewStateImplCopyWithImpl<_$GameBoardViewStateImpl>(
          this, _$identity);
}

abstract class _GameBoardViewState implements GameBoardViewState {
  const factory _GameBoardViewState(
          {final List<List<Piece?>> board,
          final int? selectedIndex,
          final GameStatus gameStatus,
          final List<Pair<int, int>> validMovesOfSelectedPiece}) =
      _$GameBoardViewStateImpl;

  @override
  List<List<Piece?>> get board;
  @override
  int? get selectedIndex;
  @override
  GameStatus get gameStatus;
  @override
  List<Pair<int, int>> get validMovesOfSelectedPiece;
  @override
  @JsonKey(ignore: true)
  _$$GameBoardViewStateImplCopyWith<_$GameBoardViewStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
