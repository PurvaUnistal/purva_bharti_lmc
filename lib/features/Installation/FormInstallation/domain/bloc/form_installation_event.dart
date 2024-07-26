import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FormInstallationEvent extends Equatable {}

class FormInstallationPageLoadEvent extends FormInstallationEvent {
  final BuildContext context;
  FormInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectProposedDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectProposedDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectActualWorkDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectActualWorkDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectMeterReadingDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectMeterReadingDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectTypeNRValueEvent extends FormInstallationEvent {
  final dynamic typeOfNRValue;
  SelectTypeNRValueEvent({required this.typeOfNRValue});
  @override
  // TODO: implement props
  List<Object> get props => [typeOfNRValue];
}

class SelectDelayReasonValueEvent extends FormInstallationEvent {
  final dynamic delayReasonValue;
  SelectDelayReasonValueEvent({required this.delayReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [delayReasonValue];
}

class SelectNGCValueEvent extends FormInstallationEvent {
  final dynamic readyNGCValue;
  SelectNGCValueEvent({required this.readyNGCValue});
  @override
  // TODO: implement props
  List<Object> get props => [readyNGCValue];
}

class SelectMeterNumberValueEvent extends FormInstallationEvent {
  final BuildContext context;
  final String meterReadingValue;
  SelectMeterNumberValueEvent({required this.context, required this.meterReadingValue});
  @override
  // TODO: implement props
  List<Object> get props => [context,meterReadingValue];
}

class CaptureGalleryMeterEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraMeterEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MeterInitReadingEvent extends FormInstallationEvent{
  @override
  List<Object?> get props => [];
}

class SelectProposedConDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectProposedConDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectRFCDeclarationDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectRFCDeclarationDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfSREvent extends FormInstallationEvent {
  final BuildContext context;
  SelectLocationOfSREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfHouseEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectLocationOfHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectQTYLMCEvent extends FormInstallationEvent {
  final String qtyValue;
  final BuildContext context;
  final int index;
  SelectQTYLMCEvent({required this.qtyValue,required this.context, required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context, index];
}

class SelectRegulatorsValueEvent extends FormInstallationEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue,context];
}

class CaptureGalleryRFCCardEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraRFCCardEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryPneumaticEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraPneumaticEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryInstallationEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraInstallationEvent extends FormInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SelectRFCCheckValueEvent extends FormInstallationEvent {
  final bool isSelected;
  final BuildContext context;
  final int index;
  SelectRFCCheckValueEvent({required this.isSelected, required this.context, required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected,context, index];
}


class SubmitFormInstallationEvent extends FormInstallationEvent {
  final BuildContext context;
  SubmitFormInstallationEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
