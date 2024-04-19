import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PreviewFeasibilityEvent extends Equatable{}

class PreviewFeasibilityPageLoadEvent extends PreviewFeasibilityEvent {
  final BuildContext context;
  PreviewFeasibilityPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
