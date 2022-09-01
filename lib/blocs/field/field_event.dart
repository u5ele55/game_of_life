part of 'field_bloc.dart';

abstract class FieldEvent {}

class ToggleStatusEvent extends FieldEvent {}

class TapCellEvent extends FieldEvent {
  final Position position;

  TapCellEvent(this.position);
}

class InitFieldEvent extends FieldEvent {}

class UpdateFieldEvent extends FieldEvent {}
