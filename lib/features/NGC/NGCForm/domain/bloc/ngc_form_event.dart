import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';

abstract class NGCFormEvent extends Equatable {}

class NGCFormLoadEvent extends NGCFormEvent {
  final BuildContext context;
  NGCFormLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}


class SelectMeterReplaceEvent extends NGCFormEvent {
  final BuildContext context;
  final bool meterReplace;
  SelectMeterReplaceEvent({required this.context, required this.meterReplace});
  @override
  // TODO: implement props
  List<Object> get props => [context,meterReplace];
}

class SelectMeterNumberValueEvent extends NGCFormEvent {
  final BuildContext context;
  final String meterReadingValue;
  SelectMeterNumberValueEvent({required this.context, required this.meterReadingValue});
  @override
  // TODO: implement props
  List<Object> get props => [context,meterReadingValue];
}

class SelectRegulatorTypeValueEvent extends NGCFormEvent {
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

class SelectRegulatorsValueEvent extends NGCFormEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue,context];
}

class SelectNgcChargeDateEvent extends NGCFormEvent{
  final BuildContext context;
  SelectNgcChargeDateEvent({ required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectProposedNgcConversionDateEvent extends NGCFormEvent{
  final BuildContext context;
  SelectProposedNgcConversionDateEvent({ required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectDelayReasonValueEvent extends NGCFormEvent {
  final LmcReasonModel delayReasonValue;
  SelectDelayReasonValueEvent({required this.delayReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [delayReasonValue];
}

class SelectLocationOfSREvent extends NGCFormEvent {
  final BuildContext context;
  SelectLocationOfSREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfHouseEvent extends NGCFormEvent {
  final BuildContext context;
  SelectLocationOfHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureGalleryMeterEvent extends NGCFormEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraMeterEvent extends NGCFormEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryNGCReportEvent extends NGCFormEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraNGCReportEvent extends NGCFormEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class NGCSubmitEvent extends NGCFormEvent {
  final BuildContext context;
  NGCSubmitEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
