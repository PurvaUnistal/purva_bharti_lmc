import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';

abstract class FormInstallationEvent extends Equatable {}

class FormInstallationPageLoadEvent extends FormInstallationEvent {
  final BuildContext context;
  FormInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectInstallationDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectInstallationDateEvent({required this.context});
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

class SelectInstallRegulatorEvent extends FormInstallationEvent {
  final BuildContext context;
  final bool installRegulator;
  SelectInstallRegulatorEvent({required this.context, required this.installRegulator});
  @override
  // TODO: implement props
  List<Object> get props => [context,installRegulator];
}

class SelectRegulatorTypeValueEvent extends FormInstallationEvent {
  final BuildContext context;
  final LmcReasonModel regulatorTypeValue;
  SelectRegulatorTypeValueEvent({
    required this.context,
    required this.regulatorTypeValue,
  });
  @override
  // TODO: implement props
  List<Object> get props => [regulatorTypeValue,context];
}

class SelectRegulatorsValueEvent extends FormInstallationEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue,context];
}

class SelectMREvent extends FormInstallationEvent {
  final String mRegulators;
  final BuildContext context;
  SelectMREvent({required this.mRegulators, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [mRegulators,context];
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
class CaptureGalleryHouseEvent extends FormInstallationEvent{
  final BuildContext context;
  CaptureGalleryHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context,];
}

class CaptureCameraHouseEvent extends FormInstallationEvent{
  final BuildContext context;
  CaptureCameraHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context,];
}

class MeterInitReadingEvent extends FormInstallationEvent{
  @override
  List<Object?> get props => [];
}

class SelectNGConversionDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectNGConversionDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectRFCDateEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectRFCDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class SelectQTYLMCEvent extends FormInstallationEvent {
  final String qtyValue;
  final BuildContext context;
  SelectQTYLMCEvent({required this.qtyValue,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context,];
}

class SelectQTYLMCCopperEvent extends FormInstallationEvent {
  final String qtyValue;
  final BuildContext context;
  SelectQTYLMCCopperEvent({required this.qtyValue,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context,];
}

class SelectLocationOfHouseEvent extends FormInstallationEvent {
  final BuildContext context;
  SelectLocationOfHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
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

class ToggleOptionEvent extends FormInstallationEvent {
  final String option;
  final bool isSelected;
  ToggleOptionEvent({required this.option, required this.isSelected});

  @override
  List<Object?> get props => [option, isSelected];
}

class SelectGasifiedRadioEvent extends FormInstallationEvent {
  final String option;
  SelectGasifiedRadioEvent({required this.option,});

  @override
  List<Object?> get props => [option,];
}

class SelectManualPipeEvent extends FormInstallationEvent {
  final bool isValue;
  SelectManualPipeEvent({required this.isValue,});
  @override
  List<Object?> get props => [isValue];
}


class SubmitFormInstallationEvent extends FormInstallationEvent {
  final BuildContext context;
  SubmitFormInstallationEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
