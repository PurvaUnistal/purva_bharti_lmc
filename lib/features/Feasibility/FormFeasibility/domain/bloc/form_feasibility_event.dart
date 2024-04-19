import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

abstract class FormFeasibilityEvent extends Equatable{}

class FormFeasibilityPageLoadEvent extends FormFeasibilityEvent {
  final BuildContext context;
  FormFeasibilityPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectProposedDateEvent extends FormFeasibilityEvent {
  final BuildContext context;
  SelectProposedDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectFeasibilityDateEvent extends FormFeasibilityEvent {
  final BuildContext context;
  SelectFeasibilityDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectCheckFeasibilityValueEvent extends FormFeasibilityEvent {
  final dynamic checkFeasibility;
  SelectCheckFeasibilityValueEvent({required this.checkFeasibility});
  @override
  // TODO: implement props
  List<Object> get props => [checkFeasibility];
}

class SubmitFormFeasibilityEvent extends FormFeasibilityEvent {
  final BuildContext context;
  SubmitFormFeasibilityEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
