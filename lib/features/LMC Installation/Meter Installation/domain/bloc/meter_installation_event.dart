import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class MeterInstallationEvent extends Equatable{}

class MeterInstallationPageLoadEvent extends MeterInstallationEvent {
  final BuildContext context;
  MeterInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends MeterInstallationEvent {
  final dynamic allAreaValue;
  SelectAreaValueEvent({this.allAreaValue});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue];
}

class SearchBpNumberEvent extends MeterInstallationEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class LoadMoreTableEvent extends MeterInstallationEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}