import 'package:flutter/material.dart';
import 'package:game_of_life/constants/game.dart';
import 'package:game_of_life/models/field.dart';

class CellPainter extends CustomPainter {
  final GameField field;

  CellPainter(this.field);
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = cellColor
      ..style = PaintingStyle.fill;
    for (int i = 0; i < (field.field?.length ?? 0); i++) {
      for (int j = 0; j < (field.field?[i].length ?? 0); j++) {
        final cell = field.field?[i][j];
        if (cell != null && cell.isAlive) {
          canvas.drawRect(
              Offset(j * cellSize, i * cellSize) &
                  const Size(cellSize, cellSize),
              paint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
