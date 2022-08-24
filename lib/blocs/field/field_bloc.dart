import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_of_life/constants/game_sizes.dart';
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

    print("toggle ${state.status} to $newStatus");
    emit(state.copyWith(
      status: newStatus,
    ));
  }

  void _onTapCell(TapCellEvent event, Emitter<FieldState> emit) {
    if (state.status == FieldStatus.stopped) {
      emit(state.copyWith(
        field: state.field..toggleCell(event.cell),
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

  void _onUpdateField(UpdateFieldEvent event, Emitter<FieldState> emitt) {
    print("try upd");
    if (state.status != FieldStatus.playing) return;

    List<List<GameCell>> newField = List.filled(fieldHeight, []);
    for (int i = 0; i < fieldHeight; i++) {
      newField[i] = List.filled(fieldWidth, GameCell());
      for (int j = 0; j < fieldWidth; j++) {
        final position = Position(x: j, y: i);
        GameCell cell = state.field.get(position) ?? GameCell();
        int aliveNeighbours = state.field.aliveNeighbours(cell);
        newField[i][j] = cell;
        if (cell.isAlive && (aliveNeighbours == 2 || aliveNeighbours == 3)) {
          continue;
        } else if (!cell.isAlive && aliveNeighbours == 3) {
          newField[i][j].isAlive = true;
          print("now $cell is alive");
        } else {
          newField[i][j].isAlive = false;
        }
      }
    }

    print("upd success");
    emit(state.copyWith(
      field: state.field..field = newField,
    ));
  }
}
