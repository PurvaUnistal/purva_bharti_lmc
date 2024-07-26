import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PreviewInstallationEvent extends Equatable{}

class PreviewInstallationPageLoadEvent extends PreviewInstallationEvent {
  final BuildContext context;
  PreviewInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
