part 'cell.dart';

class GameField {
  List<List<GameCell>>? field;

  /// Toggles cell state. If cell is dont exist, does nothing.
  void toggleCell(GameCell cell) {
    if (field == null) return;
    if (get(cell.position) == null) return;

    field![cell.position.y][cell.position.x].isAlive =
        !field![cell.position.y][cell.position.x].isAlive;
  }

  /// Returns [GameCell] with provided [position]. If [position] is out of field, returns null.
  GameCell? get(Position position) {
    if (field == null) return null;
    if (position.x < 0 || position.y < 0) return null;
    if (field!.length <= position.y) return null;
    if (field![position.y].length <= position.x) return null;
    return field![position.y][position.x];
  }

  /// Returns quantity of alive neighbours
  int aliveNeighbours(GameCell cell) {
    int cnt = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i | j == 0) continue;
        if (get(cell.position + Position(x: i, y: j))?.isAlive ?? false) cnt++;
      }
    }
    return cnt;
  }
}
