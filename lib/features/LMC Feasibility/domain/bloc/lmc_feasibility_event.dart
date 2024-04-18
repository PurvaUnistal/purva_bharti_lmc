import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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