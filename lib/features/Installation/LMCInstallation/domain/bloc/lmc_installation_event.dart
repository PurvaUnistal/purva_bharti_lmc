import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class LMCInstallationEvent extends Equatable {}

class LMCInstallationPageLoadEvent extends LMCInstallationEvent {
  final BuildContext context;
  LMCInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends LMCInstallationEvent {
  final GetAllAreaModel allAreaValue;
  final BuildContext context;
  SelectAreaValueEvent({required this.allAreaValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue, context];
}

class SearchBpNumberEvent extends LMCInstallationEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}
class LoadMoreInstallationEvent extends LMCInstallationEvent {
  final BuildContext context;
  LoadMoreInstallationEvent({required this.context});

  @override
  // TODO: implement props
  List<Object?> get props => [context];
}

class LoadMoreTableEvent extends LMCInstallationEvent {
  final BuildContext context;
  LoadMoreTableEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
