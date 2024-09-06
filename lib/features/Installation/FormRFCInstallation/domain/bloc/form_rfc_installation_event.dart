import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';

abstract class FormRFCInstallationEvent extends Equatable {}

class FormRFCInstallationPageLoadEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  FormRFCInstallationPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectInstallationDateEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  SelectInstallationDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class SelectDelayReasonValueEvent extends FormRFCInstallationEvent {
  final dynamic delayReasonValue;
  SelectDelayReasonValueEvent({required this.delayReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [delayReasonValue];
}

class SelectInstallRegulatorEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  final bool installRegulator;
  SelectInstallRegulatorEvent({required this.context, required this.installRegulator});
  @override
  // TODO: implement props
  List<Object> get props => [context,installRegulator];
}

class SelectRegulatorTypeValueEvent extends FormRFCInstallationEvent {
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

class SelectRegulatorsValueEvent extends FormRFCInstallationEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue,context];
}

class SelectSREvent extends FormRFCInstallationEvent {
  final String sRegulators;
  final BuildContext context;
  SelectSREvent({required this.sRegulators, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [sRegulators,context];
}

class SelectNGCValueEvent extends FormRFCInstallationEvent {
  final dynamic readyNGCValue;
  SelectNGCValueEvent({required this.readyNGCValue});
  @override
  // TODO: implement props
  List<Object> get props => [readyNGCValue];
}

class SelectMeterNumberValueEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  final String meterReadingValue;
  SelectMeterNumberValueEvent({required this.context, required this.meterReadingValue});
  @override
  // TODO: implement props
  List<Object> get props => [context,meterReadingValue];
}

class CaptureGalleryMeterEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraMeterEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class CaptureGalleryHouseEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraHouseEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}



class MeterInitReadingEvent extends FormRFCInstallationEvent{
  @override
  List<Object?> get props => [];
}

class SelectNGConversionDateEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  SelectNGConversionDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectRFCDateEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  SelectRFCDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class SelectQTYLMCEvent extends FormRFCInstallationEvent {
  final String qtyValue;
  final BuildContext context;
  SelectQTYLMCEvent({required this.qtyValue,required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [qtyValue,context,];
}


class SelectLocationOfHouseEvent extends FormRFCInstallationEvent {
  final BuildContext context;
  SelectLocationOfHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureGalleryRFCCardEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraRFCCardEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryPneumaticEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraPneumaticEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryInstallationEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraInstallationEvent extends FormRFCInstallationEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SelectRFCCheckValueEvent extends FormRFCInstallationEvent {
  final bool isSelected;
  final BuildContext context;
  final int index;
  SelectRFCCheckValueEvent({required this.isSelected, required this.context, required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected,context, index];
}


class SubmitFormRFCInstallation extends FormRFCInstallationEvent {
  final BuildContext context;
  SubmitFormRFCInstallation({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
