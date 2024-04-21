import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

class SelectActualWorkDateEvent extends FormMeterEvent {
  final BuildContext context;
  SelectActualWorkDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectMeterReadingDateEvent extends FormMeterEvent {
  final BuildContext context;
  SelectMeterReadingDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectTypeNRValueEvent extends FormMeterEvent {
  final dynamic typeOfNRValue;
  SelectTypeNRValueEvent({required this.typeOfNRValue});
  @override
  // TODO: implement props
  List<Object> get props => [typeOfNRValue];
}

class SelectDelayReasonValueEvent extends FormMeterEvent {
  final dynamic delayReasonValue;
  SelectDelayReasonValueEvent({required this.delayReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [delayReasonValue];
}

class SubmitFormMeterEvent extends FormMeterEvent {
  final BuildContext context;
  SubmitFormMeterEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
