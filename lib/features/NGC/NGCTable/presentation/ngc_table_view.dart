import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
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
import 'package:lmc/features/NGC/NGCForm/presentation/ngc_form_view.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_event.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_state.dart';

class NgcTableView extends StatefulWidget {
  const NgcTableView({Key? key}) : super(key: key);

  @override
  _NgcTableViewState createState() => _NgcTableViewState();
}

class _NgcTableViewState extends State<NgcTableView> {
  final ScrollController _horizontalScrollController = ScrollController();
  final ScrollController _verticalScrollController = ScrollController();

  // ---- lazy loading state ----
  static const int _pageSize = 20;   // rows added per batch
  int _displayCount = _pageSize;     // rows currently visible
  bool _isLoadingMore = false;

  // column widths (header and rows must match)
  static const double _wSno = 60;
  static const double _wReady = 110;
  static const double _wMobile = 120;
  static const double _wBp = 120;
  static const double _wArea = 140;
  static const double _wName = 140;
  static const double _wDate = 140;
  static const double _tableWidth =
      _wSno + _wReady + _wMobile + _wBp + _wArea + _wName + _wDate;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<NgcTableBloc>(context)
        .add(NgcTablePageLoadEvent(context: context));
    _verticalScrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_isLoadingMore) return;
    // when the user is within 200px of the bottom, load the next batch
    if (_verticalScrollController.position.pixels >=
        _verticalScrollController.position.maxScrollExtent - 200) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    setState(() => _isLoadingMore = true);
    // small delay so the bottom loader is visible and the UI stays smooth
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    setState(() {
      _displayCount += _pageSize;
      _isLoadingMore = false;
    });
  }

  @override
  void dispose() {
    _verticalScrollController.removeListener(_onScroll);
    _verticalScrollController.dispose();
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(
        title: AppString.ngConH,
        boolLeading: true,
      ),
      body: SafeArea(
        child: BackgroundWidget(
          child: BlocBuilder<NgcTableBloc, NgcTableState>(
            builder: (context, state) {
              if (state is FetchNgcTableDataState) {
                return _buildLayout(dataState: state);
              } else {
                return const Center(child: SpinLoader());
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLayout({required FetchNgcTableDataState dataState}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
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
        Text("Click on row to open NG Conversion Form", style: Styles.labels),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _dataTableWidget(dataState: dataState),
          ),
        ),
      ],
    );
  }

  Widget _areaDropDown({required FetchNgcTableDataState dataState}) {
    return DropdownWidget<GetAllAreaModel>(
      label: AppString.selectArea,
      hint: AppString.selectArea,
      dropdownValue: dataState.allAreaValue.gid != null ? dataState.allAreaValue : null,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        setState(() => _displayCount = _pageSize);
        BlocProvider.of<NgcTableBloc>(context).add(SelectAreaValueEvent(allAreaValue: newVal!, context: context));
      },
    );
  }

  Widget _searchTextField({required FetchNgcTableDataState dataState}) {
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
        // reset lazy loading when search changes
        setState(() => _displayCount = _pageSize);
        BlocProvider.of<NgcTableBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required FetchNgcTableDataState dataState}) {
    if (dataState.isAreaFilter != false) {
      return const Center(child: SpinLoader());
    }
    final records = dataState.listOfFilterInstallationByNgc;
    if (dataState.lmcInstallationByNgcModel.success == 400 || records.isEmpty) {
      return const Center(child: Text("No records found"));
    }

    final visibleCount =
    _displayCount > records.length ? records.length : _displayCount;

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
                  // extra item at the end ONLY while loading more
                  itemCount: visibleCount + (_isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index >= visibleCount) {
                      // ---- bottom loader, shown while next batch loads ----
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
          _headerCell("Ready for NGC", _wReady),
          _headerCell("Mobile Number", _wMobile),
          _headerCell("BP Number", _wBp),
          _headerCell("Area", _wArea),
          _headerCell("First Name", _wName),
          _headerCell("Installation Date", _wDate),
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
    return InkWell(
      onTap: () => _onRowTap(user),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.green[800]!, width: 1),
          ),
        ),
        child: Row(
          children: [
            _rowCell((index + 1 + (pageNo - 1) * 10).toString(), _wSno),
            _rowCell("Yes", _wReady, color: Colors.green[800]),
            _rowCell(user.mobileNumber.toString(), _wMobile),
            _rowCell(user.bpNumber.toString(), _wBp),
            _rowCell(user.areaName.toString(), _wArea),
            _rowCell(user.firstName.toString(), _wName),
            _rowCell(user.dateOfRegistration.toString(), _wDate),
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
        style: color != null
            ? Styles.texts.copyWith(color: color)
            : Styles.texts,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Future<void> _onRowTap(dynamic user) async {
    await AppConfig.instanceInit()?.setNGCData(newNGCData: user);
    await SharedPref.setString(
        key: PrefsValue.dmaUserId, value: user.dmaUserId ?? "");
    await SharedPref.setString(
        key: PrefsValue.lmcInstallationId, value: user.lmcInstallationId ?? "");
    await SharedPref.setString(
        key: PrefsValue.isInstall, value: user.isInstall ?? "");
    await SharedPref.setString(
        key: PrefsValue.bpNumber, value: user.bpNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterReading, value: user.meterreading ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterNumberId, value: user.meterNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterNumberSerial, value: user.meterSerial ?? "");
    await SharedPref.setString(
        key: PrefsValue.mobileNumber, value: user.mobileNumber ?? "");
    await SharedPref.setString(
        key: PrefsValue.alternateMobileNo,
        value: user.alternateMobileNo ?? "");
    await SharedPref.setString(key: PrefsValue.email, value: user.email ?? "");
    await SharedPref.setString(
        key: PrefsValue.ngOfBurners, value: user.ngOfBurners ?? "");
    await SharedPref.setString(
        key: PrefsValue.noOfFamilyMembers, value: user.dmafamily ?? "");
    await SharedPref.setString(
        key: PrefsValue.workCompletedDate,
        value: user.workCompletedDate ?? "");
    await SharedPref.setString(
        key: PrefsValue.typeOfNr, value: user.typeOfNr ?? "");
    await SharedPref.setString(
        key: PrefsValue.rfcDate, value: user.rfcDate ?? "");
    await SharedPref.setString(
        key: PrefsValue.lmcInstallationDate,
        value: user.lmcInstallationDate ?? "");
    await SharedPref.setString(
        key: PrefsValue.proposedNgcDate,
        value: user.lmcProposedNgcDate ?? AppString.dateFormat);
    await SharedPref.setString(
        key: PrefsValue.lmcPath, value: user.lmcpath ?? "");
    await SharedPref.setString(
        key: PrefsValue.meterPhoto, value: user.meterPhoto ?? "");
    await SharedPref.setString(
        key: PrefsValue.regulatorType, value: user.regulatorType ?? "");
    await SharedPref.setString(
        key: PrefsValue.regulatorTypeId, value: user.regulatorTypeId ?? "");
    await SharedPref.setString(
        key: PrefsValue.srRegulatorId, value: user.mrRegulatorId ?? "");
    await SharedPref.setString(
        key: PrefsValue.srRegulatorSerial, value: user.mrRegulatorSerial ?? "");
    await SharedPref.setString(
        key: PrefsValue.mrRegulatorId, value: user.regulators ?? "");
    await SharedPref.setString(
        key: PrefsValue.mrRegulatorSerial, value: user.regulatorSerial ?? "");
    await SharedPref.setString(
        key: PrefsValue.regulatorCheck, value: user.regulatorCheck ?? "");
    await SharedPref.setString(
        key: PrefsValue.rfcPhoto, value: user.rfcForm ?? "");
    await SharedPref.setString(
        key: PrefsValue.pneumaticPhoto, value: user.pneumaticImage ?? "");
    await SharedPref.setString(
        key: PrefsValue.extraPipe, value: user.extraPipe ?? "");
    await SharedPref.setString(
        key: PrefsValue.extraPrice, value: user.extraPrice ?? "");
    await SharedPref.setString(
        key: PrefsValue.pinCode, value: user.propertyCategoryId ?? "");
    if (!mounted) return;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => NGCFormView()));
  }
}