import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/DottedLoader.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/button_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/features/Installation/FormInstallation/presentation/form_installation_view.dart';
import 'package:lmc/features/Installation/FormRFCInstallation/presentation/form_rfc_installation_view.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_bloc.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_event.dart';
import 'package:lmc/features/Installation/PreviewInstallation/domain/bloc/preview_installation_state.dart';

class PreviewInstallationView extends StatefulWidget {
  const PreviewInstallationView({super.key});

  @override
  State<PreviewInstallationView> createState() =>
      _PreviewInstallationViewState();
}

class _PreviewInstallationViewState extends State<PreviewInstallationView> {
  static const Color _ink = Color(0xFF1F2A37);
  static const Color _muted = Color(0xFF6B7280);
  static const Color _line = Color(0xFFE5E7EB);

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PreviewInstallationBloc>(context)
        .add(PreviewInstallationPageLoadEvent(context: context));
  }

  Color get _primary => EnvironmentConfig.of(context)!.primaryTheme;

  String _v(String? value) =>
      (value == null || value.trim().isEmpty) ? '—' : value.trim();

  String _initials(String first, String last) {
    final f = first.trim().isNotEmpty ? first.trim()[0] : '';
    final l = last.trim().isNotEmpty ? last.trim()[0] : '';
    final r = (f + l).toUpperCase();
    return r.isEmpty ? '?' : r;
  }

  void _copy(String label, String value) {
    if (value.trim().isEmpty) return;
    Clipboard.setData(ClipboardData(text: value.trim()));
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
        content: Text('$label copied'),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(title: AppString.lmcInstallH, boolLeading: true),
      body: SafeArea(
        child: BackgroundWidget(
          child:
          BlocBuilder<PreviewInstallationBloc, PreviewInstallationState>(
            builder: (context, state) {
              if (state is PreviewInstallationDataState) {
                return _screen(state);
              }
              return Center(child: SpinLoader());
            },
          ),
        ),
      ),
    );
  }

  /// Fits everything on one screen; only scrolls if the device is too small.
  Widget _screen(PreviewInstallationDataState s) {
    return LayoutBuilder(
      builder: (context, constraints) => SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _header(s),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                          child: _tile(Icons.bolt_rounded,
                              AppString.chargeArea, s.chargeArea)),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _tile(Icons.location_city_rounded,
                              AppString.area, s.areaName)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _tile(Icons.event_available_rounded, AppString.lmcFeaDate,
                      s.feasibilityVisitDate),
                  const SizedBox(height: 14),
                  _address(s),
                  const Spacer(),
                  const SizedBox(height: 14),
                  _button(s),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------- Header: name, mobile, CR, BP ----------------

  Widget _header(PreviewInstallationDataState s) {
    final name = '${s.firstName} ${s.lastName}'.trim();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _primary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: _primary.withOpacity(0.25),
              blurRadius: 14,
              offset: const Offset(0, 6)),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.white,
                child: Text(_initials(s.firstName, s.lastName),
                    style: TextStyle(
                        color: _primary,
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name.isEmpty ? '—' : name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(height: 3),
                    GestureDetector(
                      onTap: () =>
                          _copy(AppString.mobileNumber, s.mobileNumber),
                      child: Row(
                        children: [
                          Icon(Icons.phone_rounded,
                              size: 14, color: Colors.white.withOpacity(0.85)),
                          const SizedBox(width: 5),
                          Text(_v(s.mobileNumber),
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  fontSize: 13.5,
                                  letterSpacing: 0.3)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _pill(AppString.crNumber, s.custRegNo)),
              const SizedBox(width: 8),
              Expanded(child: _pill(AppString.bpNumber, s.bpNumber)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _pill(String label, String value) {
    return Material(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _copy(label, value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75), fontSize: 11)),
              const SizedBox(height: 2),
              Text(_v(value),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------- Info tiles ----------------

  Widget _tile(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: _primary.withOpacity(0.07),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: _primary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: _muted, fontSize: 11.5)),
                Text(_v(value),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: _ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w700)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- Address grid + PIN ----------------

  Widget _address(PreviewInstallationDataState s) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _line),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
            child: Row(
              children: [
                Icon(Icons.home_outlined, size: 18, color: _primary),
                const SizedBox(width: 6),
                const Expanded(
                  child: Text('Address',
                      style: TextStyle(
                          color: _ink,
                          fontSize: 14.5,
                          fontWeight: FontWeight.w700)),
                ),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text('${AppString.pinCode}: ${_v(s.pinCode)}',
                      style: TextStyle(
                          color: _primary,
                          fontSize: 12.5,
                          fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 6, 14, 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: _field(
                            AppString.buildingNumber, s.buildingNumber)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _field(AppString.houseNumber, s.houseNumber)),
                  ],
                ),
                const Divider(height: 18, color: _line),
                Row(
                  children: [
                    Expanded(child: _field(AppString.street, s.locality)),
                    const SizedBox(width: 12),
                    Expanded(child: _field(AppString.town, s.town)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _field(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: _muted, fontSize: 11.5)),
        const SizedBox(height: 2),
        Text(_v(value),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                color: _ink, fontSize: 14, fontWeight: FontWeight.w600)),
      ],
    );
  }

  // ---------------- Button (original navigation logic) ----------------

  Widget _button(PreviewInstallationDataState s) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: s.isLoader == false
          ? SizedBox(
        key: const ValueKey('btn'),
        width: double.infinity,
        child: ButtonWidget(
          text: AppString.installation,
          onPressed: () {
            if (s.rfcProcessStatus == '' && s.lmcInstallId == '') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FormInstallationView()),
              );
            } else if (s.rfcProcessStatus == '') {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => FormRFCInstallationView()),
              );
            }
          },
        ),
      )
          : SizedBox(
        key: const ValueKey('loader'),
        height: 48,
        child: Center(child: DottedLoaderWidget()),
      ),
    );
  }
}