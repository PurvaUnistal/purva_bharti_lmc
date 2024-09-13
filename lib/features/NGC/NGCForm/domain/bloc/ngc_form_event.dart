import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lmc/features/Feasibility/FormFeasibility/domain/model/GetConstantModel.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/model/LmcReasonModel.dart';

abstract class NGCFormEvent extends Equatable {}

class NGCFormLoadEvent extends NGCFormEvent {
  final BuildContext context;
  NGCFormLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class MeterInitReadingEvent extends NGCFormEvent {
  @override
  List<Object?> get props => [];
}

class SelectTypeNRValueEvent extends NGCFormEvent {
  final GetConstantModel typeOfNRValue;
  SelectTypeNRValueEvent({required this.typeOfNRValue});
  @override
  // TODO: implement props
  List<Object> get props => [typeOfNRValue];
}

class SelectMeterReplaceEvent extends NGCFormEvent {
  final BuildContext context;
  final bool meterReplace;
  SelectMeterReplaceEvent({required this.context, required this.meterReplace});
  @override
  // TODO: implement props
  List<Object> get props => [context, meterReplace];
}
class SelectRegularReplaceEvent extends NGCFormEvent {
  final BuildContext context;
  final bool regularReplace;
  SelectRegularReplaceEvent({required this.context, required this.regularReplace});
  @override
  // TODO: implement props
  List<Object> get props => [context, regularReplace];
}

class SelectMeterNumberValueEvent extends NGCFormEvent {
  final BuildContext context;
  final String meterReadingValue;
  SelectMeterNumberValueEvent({required this.context, required this.meterReadingValue});
  @override
  // TODO: implement props
  List<Object> get props => [context, meterReadingValue];
}

class SelectNGConversionDateEvent extends NGCFormEvent {
  final BuildContext context;
  SelectNGConversionDateEvent({
    required this.context,
  });
  @override
  // TODO: implement props
  List<Object> get props => [
        context,
      ];
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
  List<Object> get props => [regulatorTypeValue, context];
}

class SelectRegulatorsValueEvent extends NGCFormEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue, context];
}

class SelectSRegulatorsEvent extends NGCFormEvent {
  final String sRegulators;
  final BuildContext context;
  SelectSRegulatorsEvent({required this.sRegulators, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [sRegulators, context];
}

class SelectDelayReasonValueEvent extends NGCFormEvent {
  final LmcReasonModel delayReasonValue;
  SelectDelayReasonValueEvent({required this.delayReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [delayReasonValue];
}

class SelectMeterTypeValueEvent extends NGCFormEvent {
  final LmcReasonModel meterTypeValue;
  SelectMeterTypeValueEvent({required this.meterTypeValue});
  @override
  // TODO: implement props
  List<Object> get props => [meterTypeValue];
}

class SelectLocationOfSREvent extends NGCFormEvent {
  final BuildContext context;
  SelectLocationOfSREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfMREvent extends NGCFormEvent {
  final BuildContext context;
  SelectLocationOfMREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureGalleryMeterEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraMeterEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryNGCReportEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraNGCReportEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryMREvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraMREvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGallerySREvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraSREvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class CaptureGalleryPneumaticEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraPneumaticEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
class CaptureGalleryRfcEvent extends NGCFormEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraRfcEvent extends NGCFormEvent {
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
