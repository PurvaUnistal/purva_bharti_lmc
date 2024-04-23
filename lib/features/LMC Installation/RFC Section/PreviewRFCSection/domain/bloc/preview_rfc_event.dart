import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PreviewRFCEvent extends Equatable{}

class PreviewRFCPageLoadEvent extends PreviewRFCEvent {
  final BuildContext context;
  PreviewRFCPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
