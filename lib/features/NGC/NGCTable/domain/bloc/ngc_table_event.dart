import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';

abstract class NgcTableEvent extends Equatable {}

class NgcTablePageLoadEvent extends NgcTableEvent {
  final BuildContext context;
  NgcTablePageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectAreaValueEvent extends NgcTableEvent {
  final GetAllAreaModel allAreaValue;
  final BuildContext context;
  SelectAreaValueEvent({ required this.allAreaValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [allAreaValue, context];
}

class SearchBpNumberEvent extends NgcTableEvent {
  final BuildContext context;
  final String searchBpNumber;
  SearchBpNumberEvent({required this.context, required this.searchBpNumber});
  @override
  // TODO: implement props
  List<Object> get props => [context, searchBpNumber];
}

class NgcTableLoadMoreEvent extends NgcTableEvent {
  final BuildContext context;
  NgcTableLoadMoreEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
