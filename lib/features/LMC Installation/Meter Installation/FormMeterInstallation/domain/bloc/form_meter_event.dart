import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Meter/LMC%20Meter/domain/model/MeterModel.dart';

abstract class FormMeterEvent extends Equatable {}

class FormMeterPageLoadEvent extends FormMeterEvent {
  final BuildContext context;
  FormMeterPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectProposedDateEvent extends FormMeterEvent {
  final BuildContext context;
  SelectProposedDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectMeterDateEvent extends FormMeterEvent {
  final BuildContext context;
  SelectMeterDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectCheckMeterValueEvent extends FormMeterEvent {
  final dynamic checkMeter;
  SelectCheckMeterValueEvent({required this.checkMeter});
  @override
  // TODO: implement props
  List<Object> get props => [checkMeter];
}

class SubmitFormMeterEvent extends FormMeterEvent {
  final BuildContext context;
  SubmitFormMeterEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
