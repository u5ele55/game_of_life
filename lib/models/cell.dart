part of 'field.dart';

class Position {
  const Position({required this.x, required this.y});
  final int x, y;

  Position operator +(Position other) =>
      Position(x: x + other.x, y: y + other.y);

  @override
  String toString() => "<Position x=$x, y=$y/>";
}

class GameCell {
  GameCell({this.isAlive = false, Position? position})
      : position = position ?? const Position(x: -1, y: -1);

  bool isAlive;
  final Position position;

  @override
  String toString() => "<Cell alive=$isAlive pos=$position/>";
}
