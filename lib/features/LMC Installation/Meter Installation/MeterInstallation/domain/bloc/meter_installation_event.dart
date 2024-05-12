import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class MeterInstallationEvent extends Equatable {}

class MeterInstallationPageLoadEvent extends MeterInstallationEvent {
  final BuildContext context;
  MeterInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends MeterInstallationEvent {
  final GetAllAreaModel allAreaValue;
  final BuildContext context;
  SelectAreaValueEvent({required this.allAreaValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue, context];
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
