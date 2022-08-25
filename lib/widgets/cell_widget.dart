import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/blocs/field/field_bloc.dart';
import 'package:game_of_life/constants/game.dart';
import 'package:game_of_life/models/field.dart';

class CellWidget extends StatelessWidget {
  const CellWidget({Key? key, required this.cell}) : super(key: key);

  final GameCell cell;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<FieldBloc>().add(TapCellEvent(cell.position));
      },
      child: Container(
        height: cellSize,
        width: cellSize,
        decoration: BoxDecoration(
          color: cell.isAlive ? Colors.black : Colors.white,
          border: const Border.fromBorderSide(
              BorderSide(color: Colors.grey, width: 0.5)),
        ),
      ),
    );
  }
}
