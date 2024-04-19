import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class RFCSectionEvent extends Equatable{}

class RFCSectionPageLoadEvent extends RFCSectionEvent {
  final BuildContext context;
  RFCSectionPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends RFCSectionEvent {
  final dynamic allAreaValue;
  SelectAreaValueEvent({this.allAreaValue});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue];
}

class SearchBpNumberEvent extends RFCSectionEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends RFCSectionEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}