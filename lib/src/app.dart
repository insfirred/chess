import 'package:flutter/material.dart';

import 'ui/game_board/game_board_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameBoardView(),
    );
  }
}
