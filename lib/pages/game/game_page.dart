import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/blocs/field/field_bloc.dart';
import 'package:game_of_life/constants/game.dart' as constants;
import 'package:game_of_life/widgets/cell_widget.dart';
import 'package:zoom_widget/zoom_widget.dart';

part 'game_view.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (_) => FieldBloc()..add(InitFieldEvent()),
        child: const GameView(),
      ),
    );
  }
}
