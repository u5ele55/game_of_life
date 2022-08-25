import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/constants/game.dart';
import 'package:game_of_life/models/field.dart';

part 'field_event.dart';
part 'field_state.dart';

class FieldBloc extends Bloc<FieldEvent, FieldState> {
  FieldBloc()
      : super(FieldState(status: FieldStatus.initial, field: GameField())) {
    on<InitFieldEvent>(_onInitField);
    on<ToggleStatusEvent>(_onToggleStatus);
    on<TapCellEvent>(_onTapCell);
    on<UpdateFieldEvent>(_onUpdateField);
  }

  void _onToggleStatus(ToggleStatusEvent event, Emitter<FieldState> emit) {
    FieldStatus? newStatus;
    if (state.status == FieldStatus.playing) {
      newStatus = FieldStatus.stopped;
    } else if (state.status == FieldStatus.stopped) {
      newStatus = FieldStatus.playing;
    }

    emit(state.copyWith(
      status: newStatus,
    ));
  }

  void _onTapCell(TapCellEvent event, Emitter<FieldState> emit) {
    if (state.status == FieldStatus.stopped) {
      emit(state.copyWith(
        field: state.field
          ..toggleCell(state.field.get(event.position) ?? GameCell()),
      ));
    }
  }

  void _onInitField(InitFieldEvent event, Emitter<FieldState> emit) {
    List<List<GameCell>> newField = List.filled(fieldHeight, []);
    for (int i = 0; i < fieldHeight; i++) {
      newField[i] = List.filled(fieldWidth, GameCell());
      for (int j = 0; j < fieldWidth; j++) {
        newField[i][j] = GameCell(position: Position(x: j, y: i));
      }
    }
    emit(state.copyWith(
      status: FieldStatus.stopped,
      field: GameField()..field = newField,
    ));
  }

  void _onUpdateField(UpdateFieldEvent event, Emitter<FieldState> emit) {
    if (state.status != FieldStatus.playing) return;

    List<List<GameCell>> newField = List.filled(fieldHeight, []);
    for (int i = 0; i < fieldHeight; i++) {
      newField[i] = List.filled(fieldWidth, GameCell());
      for (int j = 0; j < fieldWidth; j++) {
        final position = Position(x: j, y: i);
        GameCell cell = state.field.get(position) ?? GameCell();
        int aliveNeighbours = state.field.aliveNeighbours(cell);
        newField[i][j] = cell.copy();
        if (cell.isAlive) {
          if (aliveNeighbours <= 1 || aliveNeighbours >= 4) {
            newField[i][j].isAlive = false;
          }
        } else {
          if (aliveNeighbours == 3) {
            newField[i][j].isAlive = true;
          }
        }
      }
    }

    emit(state.copyWith(
      field: state.field..field = newField,
    ));
  }
}
