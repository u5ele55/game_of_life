part of 'field_bloc.dart';

enum FieldStatus { initial, playing, stopped }

class FieldState {
  final FieldStatus status;
  final GameField field;

  FieldState({required this.status, required this.field});

  FieldState copyWith({
    FieldStatus? status,
    GameField? field,
  }) =>
      FieldState(
        status: status ?? this.status,
        field: field ?? this.field,
      );
}
