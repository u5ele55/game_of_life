part of 'field_bloc.dart';

abstract class FieldEvent {}

class ToggleStatusEvent extends FieldEvent {}

class TapCellEvent extends FieldEvent {
  final GameCell cell;

  TapCellEvent(this.cell);
}

class InitFieldEvent extends FieldEvent {}

class UpdateFieldEvent extends FieldEvent {}
