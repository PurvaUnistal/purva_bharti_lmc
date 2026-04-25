import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_bloc.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_event.dart';
import 'package:lmc/features/Installation/FormInstallation/domain/bloc/form_installation_state.dart';

class FullMapWidget extends StatelessWidget {
  final FormInstallationDataState dataState;

  const FullMapWidget({super.key, required this.dataState});

  @override
  Widget build(BuildContext context) {
    /// ✅ Parse lat/lng safely INSIDE build
    final double lat =
        double.tryParse(dataState.latOfHouseController.text) ?? 28.6139;

    final double lng =
        double.tryParse(dataState.longOfHouseController.text) ?? 77.2090;

    final LatLng currentLatLng = LatLng(lat, lng);

    return Scaffold(
      appBar: AppBarWidget(
        title: "Select Location",
        boolLeading: true,
      ),
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: currentLatLng,
            zoom: 18,
          ),
        
          /// ✅ VERY IMPORTANT → use bloc markers (with custom icon)
          markers: dataState.markers.isNotEmpty
              ? dataState.markers
              : {
            Marker(
              markerId: const MarkerId("fallback"),
              position: currentLatLng,
            ),
          },
        
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
        
          /// ✅ Update location on tap
          onTap: (LatLng newLatLng) {
            context.read<FormInstallationBloc>().add(
              SelectLocationOfHouseEvent(
                lat: newLatLng.latitude,
                lng: newLatLng.longitude,
                context: context,
              ),
            );
        
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}