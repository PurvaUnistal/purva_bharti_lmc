import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_config.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_bloc.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_event.dart';
import 'package:lmc/features/Installation/LMCInstallation/domain/bloc/lmc_installation_state.dart';
import 'package:lmc/features/Installation/PreviewInstallation/presentation/preview_installation_view.dart';

class LMCInstallationView extends StatefulWidget {
  const LMCInstallationView({super.key});

  @override
  State<LMCInstallationView> createState() => _LMCInstallationViewState();
}

class _LMCInstallationViewState extends State<LMCInstallationView> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  // ---- lazy loading state ----
  static const int _pageSize = 20; // rows added per batch
  int _displayCount = _pageSize;   // rows currently visible
  bool _isLoadingMore = false;

  // ---- column widths (header and rows must match) ----
  static const double _wSno = 60;
  static const double _wStatus = 110;
  static const double _wMobile = 120;
  static const double _wBp = 120;
  static const double _wArea = 140;
  static const double _wName = 140;
  static const double _tableWidth =
      _wSno + _wStatus + _wMobile + _wBp + _wArea + _wName;

  @override
  void initState() {
    BlocProvider.of<LMCInstallationBloc>(
      context,
    ).add(LMCInstallationPageLoadEvent(context: context));
    _verticalScrollController.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _verticalScrollController.removeListener(_onScroll);
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  // ---------------- lazy loading ----------------

  void _onScroll() {
    if (_isLoadingMore) return;
    // within 200px of the bottom -> load next batch
    if (_verticalScrollController.position.pixels >=
        _verticalScrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    final state = BlocProvider.of<LMCInstallationBloc>(context).state;
    if (state is! LMCInstallationDataState) return;
    final total = state.listOfFilterInstallationRow.length;

    debugPrint('loadMore: displayCount=$_displayCount total=$total');
    if (_displayCount >= total) return; // nothing more to show

    setState(() => _isLoadingMore = true); // loader row appears

    // scroll down slightly so the loader row is visible
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_verticalScrollController.hasClients) {
        _verticalScrollController.animateTo(
          _verticalScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() {
      _displayCount += _pageSize; // next batch appears
      _isLoadingMore = false;     // loader disappears
    });
  }

  // ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(title: AppString.lmcInstallH, boolLeading: true),
      body: BackgroundWidget(
        child: BlocBuilder<LMCInstallationBloc, LMCInstallationState>(
          builder: (context, state) {
            if (state is LMCInstallationDataState) {
              return _itemBuilder(dataState: state);
            } else {
              return const Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }

  Widget _itemBuilder({required LMCInstallationDataState dataState}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              CommonStyle.vertical(context: context),
              _areaDropDown(dataState: dataState),
              CommonStyle.vertical(context: context),
              _searchTextField(dataState: dataState),
            ],
          ),
        ),
        CommonStyle.vertical(context: context),
        Text(
          "Click on row to open LMC Installation Form",
          style: Styles.labels,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _dataTableWidget(dataState: dataState),
          ),
        ),
      ],
    );
  }

  Widget _areaDropDown({required LMCInstallationDataState dataState}) {
    return DropdownWidget<GetAllAreaModel>(
      label: AppString.area,
      hint: AppString.area,
      dropdownValue: dataState.allAreaValue.gid == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        setState(() => _displayCount = _pageSize);
        BlocProvider.of<LMCInstallationBloc>(context,).add(SelectAreaValueEvent(allAreaValue: newVal!, context: context));
      },
    );
  }

  Widget _searchTextField({required LMCInstallationDataState dataState}) {
    return TextFieldWidget(
      label: AppString.searchBPNumber,
      hintText: AppString.searchBPNumber,
      controller: dataState.bpNumberController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      suffixIcon: IconButtonWidget(
        iconData: Icons.search_rounded,
        onPressed: () {},
      ),
      onChanged: (val) {
        setState(() => _displayCount = _pageSize);
        BlocProvider.of<LMCInstallationBloc>(
          context,
        ).add(SearchBpNumberEvent(context: context, searchBpNumber: val));
      },
    );
  }

  Widget _dataTableWidget({required LMCInstallationDataState dataState}) {
    if (dataState.isAreaFilter != false) {
      return const Center(child: SpinLoader());
    }
    final records = dataState.listOfFilterInstallationRow;
    if (dataState.installationDoneModel.success == 400 || records.isEmpty) {
      return const Center(child: Text("No records found"));
    }
    final visibleCount = _displayCount > records.length ? records.length : _displayCount;
    return Scrollbar(
      controller: _horizontalScrollController,
      thickness: 3.0,
      scrollbarOrientation: ScrollbarOrientation.top,
      thumbVisibility: true,
      child: SingleChildScrollView(
        controller: _horizontalScrollController,
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _tableWidth,
          child: Column(
            children: [
              _headerRow(),
              Expanded(
                child: ListView.builder(
                  controller: _verticalScrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  // extra item at the end ONLY while loading more
                  itemCount: visibleCount + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= visibleCount) {
                      // ---- bottom loader while next batch loads ----
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 14.0),
                        child: Center(
                          child: SizedBox(
                            height: 26,
                            width: 26,
                            child: CircularProgressIndicator(strokeWidth: 2.5),
                          ),
                        ),
                      );
                    }
                    return _dataRow(
                      index: index,
                      user: records[index],
                      pageNo: dataState.pageNo,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerRow() {
    final headerColor = EnvironmentConfig.of(context)!.primaryTheme;
    return Container(
      color: headerColor,
      child: Row(
        children: [
          _headerCell("S.No", _wSno),
          _headerCell("Status", _wStatus),
          _headerCell("Mobile Number", _wMobile),
          _headerCell("BP Number", _wBp),
          _headerCell("Area", _wArea),
          _headerCell("Name", _wName),
        ],
      ),
    );
  }

  Widget _headerCell(String label, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _dataRow({
    required int index,
    required dynamic user,
    required int pageNo,
  }) {
    // same status logic as your DataTable version
    String statusLabel = "";
    Color? statusColor;
    if (user.rfcProcessStatus == "" && user.lmcInstallId == "") {
      statusLabel = "Installation";
      statusColor = Colors.green[800];
    } else if (user.rfcProcessStatus == "") {
      statusLabel = "RFC Pending";
      statusColor = Colors.red[800];
    }

    return InkWell(
      onTap: () => _onRowTap(user),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: EnvironmentConfig.of(context)!.primaryTheme,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            _rowCell((index + 1 + (pageNo - 1) * 10).toString(), _wSno),
            _rowCell(statusLabel, _wStatus, color: statusColor),
            _rowCell(user.mobileNumber.toString(), _wMobile),
            _rowCell(user.bpNumber.toString(), _wBp),
            _rowCell(user.areaName.toString(), _wArea),
            _rowCell(user.firstName.toString(), _wName),
          ],
        ),
      ),
    );
  }

  Widget _rowCell(String value, double width, {Color? color}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
      alignment: Alignment.center,
      child: Text(
        value,
        style:
        color != null ? Styles.texts.copyWith(color: color) : Styles.texts,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  // ---------------- row tap ----------------

  Future<void> _onRowTap(dynamic user) async {
    await AppConfig.instanceInit()?.setInstallationData(value: user);
    await SharedPref.setString(
        key: PrefsValue.lmcInstallId, value: user.lmcInstallId ?? "");
    await SharedPref.setString(
        key: PrefsValue.rfcProcessStatus, value: user.rfcProcessStatus ?? "");
    await SharedPref.setString(
        key: PrefsValue.crNumber, value: user.crn ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterLMCFeasId, value: user.lmcFeasId ?? "");
    await SharedPref.setString(
      key: PrefsValue.proposedDate,
      value: (user.proposedDate == "" || user.proposedDate == null)
          ? "00-00-0000"
          : user.proposedDate!,
    );
    await SharedPref.setString(
        key: PrefsValue.bpNumber, value: user.bpNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterDma, value: user.dma ?? "");
    await SharedPref.setString(
        key: PrefsValue.feasibilityVisitDate,
        value: user.feasibilityVisitDate ?? "");
    await SharedPref.setString(
        key: PrefsValue.chargeArea, value: user.chargeAreaName ?? "");
    await SharedPref.setString(
        key: PrefsValue.areaName, value: user.areaName ?? "");
    await SharedPref.setString(
        key: PrefsValue.firstName, value: user.firstName ?? "");
    await SharedPref.setString(
        key: PrefsValue.lastName, value: user.lastName ?? "");
    await SharedPref.setString(
        key: PrefsValue.mobileNumber, value: user.mobileNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.buildingNumber, value: user.buildingNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.houseNumber, value: user.houseNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.locality, value: user.locality ?? "");
    await SharedPref.setString(key: PrefsValue.town, value: user.town ?? "");
    await SharedPref.setString(
        key: PrefsValue.district, value: user.district ?? "");
    await SharedPref.setString(
        key: PrefsValue.pinCode, value: user.pinCode ?? "");
    await SharedPref.setString(
        key: PrefsValue.propertyCategoryId,
        value: user.propertyCategoryId ?? "");
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PreviewInstallationView()),
    );
  }
}