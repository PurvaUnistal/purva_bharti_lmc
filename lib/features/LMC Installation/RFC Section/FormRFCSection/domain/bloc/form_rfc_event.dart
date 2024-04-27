import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class FormRFCEvent extends Equatable{}

class FormRFCPageLoadEvent extends FormRFCEvent {
  final BuildContext context;
  FormRFCPageLoadEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectProposedConDateEvent extends FormRFCEvent {
  final BuildContext context;
  SelectProposedConDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectRFCDeclarationDateEvent extends FormRFCEvent {
  final BuildContext context;
  SelectRFCDeclarationDateEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfSREvent extends FormRFCEvent {
  final BuildContext context;
  SelectLocationOfSREvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectLocationOfHouseEvent extends FormRFCEvent {
  final BuildContext context;
  SelectLocationOfHouseEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}

class SelectRegulatorsValueEvent extends FormRFCEvent {
  final String regulatorsValue;
  final BuildContext context;
  SelectRegulatorsValueEvent({required this.regulatorsValue, required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [regulatorsValue,context];
}

class CaptureGalleryRFCCardEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraRFCCardEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryPneumaticEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraPneumaticEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureGalleryInstallationEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CaptureCameraInstallationEvent extends FormRFCEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SelectRFCCheckValueEvent extends FormRFCEvent {
  final bool isSelected;
  final BuildContext context;
  final int index;
  SelectRFCCheckValueEvent({required this.isSelected, required this.context, required this.index});
  @override
  // TODO: implement props
  List<Object> get props => [isSelected,context];
}
class SubmitFormRFCEvent extends FormRFCEvent {
  final BuildContext context;
  SubmitFormRFCEvent({required this.context});
  @override
  // TODO: implement props
  List<Object> get props => [context];
}
