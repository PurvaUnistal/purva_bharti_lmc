import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';

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

class SelectFollowUpDateEvent extends FormFeasibilityEvent {
  final BuildContext context;
  SelectFollowUpDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectCheckFeasibilityValueEvent extends FormFeasibilityEvent {
  final GetConstantModel checkFeasibility;
  SelectCheckFeasibilityValueEvent({required this.checkFeasibility});
  @override
  // TODO: implement props
  List<Object> get props => [checkFeasibility];
}

class SelectPipelineStatusValueEvent extends FormFeasibilityEvent {
  final GetConstantModel checkPipelineStatus;
  SelectPipelineStatusValueEvent({required this.checkPipelineStatus});
  @override
  // TODO: implement props
  List<Object> get props => [checkPipelineStatus];
}

class SelectLMCReasonValueEvent extends FormFeasibilityEvent {
  final GetConstantModel lmcReasonValue;
  SelectLMCReasonValueEvent({required this.lmcReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [lmcReasonValue];
}

class SelectQTYLMCEvent extends FormFeasibilityEvent {
  final String qtyValue;
  final BuildContext context;
  SelectQTYLMCEvent({required this.qtyValue,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context,];
}

class SelectQTYLMCCopperEvent extends FormFeasibilityEvent {
  final String qtyValue;
  final BuildContext context;
  SelectQTYLMCCopperEvent({required this.qtyValue,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context,];
}

class SelectRFCCheckValueEvent extends FormFeasibilityEvent {
  final bool isSelected;
  final BuildContext context;
  final int index;
  SelectRFCCheckValueEvent({required this.isSelected, required this.context, required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected,context, index];
}

class SelectTFAvailableEvent extends FormFeasibilityEvent {
  final bool isValue;
  SelectTFAvailableEvent({required this.isValue,});
  @override
  List<Object?> get props => [isValue];
}

class SelectManualPipeEvent extends FormFeasibilityEvent {
  final bool isValue;
  SelectManualPipeEvent({required this.isValue,});
  @override
  List<Object?> get props => [isValue];
}

class SubmitFormFeasibilityEvent extends FormFeasibilityEvent {
  final BuildContext context;
  SubmitFormFeasibilityEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
