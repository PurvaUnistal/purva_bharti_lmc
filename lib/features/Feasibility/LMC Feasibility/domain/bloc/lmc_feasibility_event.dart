import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/FeasibilityModel.dart';

abstract class LMCFeasibilityEvent extends Equatable{}

class LMCFeasibilityPageLoadEvent extends LMCFeasibilityEvent {
  final BuildContext context;
  LMCFeasibilityPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends LMCFeasibilityEvent {
  final dynamic allAreaValue;
  SelectAreaValueEvent({this.allAreaValue});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue];
}

class SearchBpNumberEvent extends LMCFeasibilityEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class PreviewPopEvent extends LMCFeasibilityEvent {
  final BuildContext context;
  final List<FeasibilityRowsList> listOfFeasibilityRow;
  PreviewPopEvent({required this.context,required this.listOfFeasibilityRow});
  @override
  // TODO: implement props
  List<Object> get props => [context,listOfFeasibilityRow];
}

class LoadMoreTableEvent extends LMCFeasibilityEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}