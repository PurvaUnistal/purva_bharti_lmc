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

class SelectMRegulatorsEvent extends NGCFormEvent {
  final String mRegulators;
  final BuildContext context;
  SelectMRegulatorsEvent({required this.mRegulators, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [mRegulators, context];
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

class SelectRegulatorTypeReasonValueEvent extends NGCFormEvent {
  final LmcReasonModel regulatorTypeReasonValue;
  SelectRegulatorTypeReasonValueEvent({required this.regulatorTypeReasonValue});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorTypeReasonValue];
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
  final BuildContext context;
  CaptureGalleryMeterEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureCameraMeterEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraMeterEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureGalleryNGCReportEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureGalleryNGCReportEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureCameraNGCReportEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraNGCReportEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class CaptureCameraMREvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraMREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}



class CaptureCameraSREvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraSREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class CaptureGalleryPneumaticEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureGalleryPneumaticEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureCameraPneumaticEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraPneumaticEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
class CaptureGalleryRfcEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureGalleryRfcEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class CaptureCameraRfcEvent extends NGCFormEvent {
  final BuildContext context;
  CaptureCameraRfcEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class NGCSubmitEvent extends NGCFormEvent {
  final BuildContext context;
  NGCSubmitEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
