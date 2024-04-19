import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class PreviewMeterInstallationEvent extends Equatable{}

class PreviewMeterInstallationPageLoadEvent extends PreviewMeterInstallationEvent {
  final BuildContext context;
  PreviewMeterInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
