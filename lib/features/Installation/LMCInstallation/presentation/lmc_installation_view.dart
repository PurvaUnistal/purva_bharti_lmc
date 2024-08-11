import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
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
  @override
  void initState() {
    BlocProvider.of<LMCInstallationBloc>(context).add(LMCInstallationPageLoadEvent(context: context));
    super.initState();
  }

  ScrollController _horizontalScrollController = ScrollController();
  ScrollController _verticalScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LMCInstallationBloc, LMCInstallationState>(
        builder: (context, state) {
          if (state is LMCInstallationDataState) {
            return BackgroundWidget(child: _itemBuilder(dataState: state));
          } else {
            return const Center(
              child: SpinLoader(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required LMCInstallationDataState dataState}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.lmcInstallH,
        boolLeading: true,
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dataState.userName,
                textAlign: TextAlign.start,
                style: Styles.rel,
              ),
              Text(
                dataState.schema,
                textAlign: TextAlign.start,
                style: Styles.rel,
              )
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                _verticalSpace(),
                _areaDropDown(dataState: dataState),
                _verticalSpace(),
                _searchTextField(dataState: dataState),
              ],
            ),
          ),
          _verticalSpace(),
          Flexible(child: _dataTableWidget(dataState: dataState)),
        ],
      ),
    );
  }

  Widget _areaDropDown({required LMCInstallationDataState dataState}) {
    return DropdownWidget<GetAllAreaModel>(
      label: AppString.area,
      hint: AppString.area,
      dropdownValue: dataState.allAreaValue == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<LMCInstallationBloc>(context).add(SelectAreaValueEvent(allAreaValue: newVal!, context: context));
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
      suffixIcon: IconButtonWidget(iconData: Icons.search_rounded, onPressed: () {}),
      onChanged: (val) {
        BlocProvider.of<LMCInstallationBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required LMCInstallationDataState dataState}) {
    var h = MediaQuery.of(context).size.height * 0.026;
    print("hh${h}");
    return dataState.installationDoneModel?.success == 400
        ? Center(child: Text("No records found"))
        : Theme(
            data: ThemeData(
              highlightColor: AppColor.primer1,
            ),
            child: Scrollbar(
              controller: _verticalScrollController,
              thickness: 3.0,
              scrollbarOrientation: ScrollbarOrientation.right,
              thumbVisibility: true,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: _verticalScrollController,
                child: Theme(
                  data: ThemeData(
                    highlightColor: AppColor.primer1,
                  ),
                  child: Scrollbar(
                    controller: _horizontalScrollController,
                    thickness: 3.0,
                    scrollbarOrientation: ScrollbarOrientation.top,
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      controller: _horizontalScrollController,
                      scrollDirection: Axis.horizontal,
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: AppColor.primer),
                        child: DataTable(
                          sortAscending: true,
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          showCheckboxColumn: false,
                          dataTextStyle: Styles.texts,
                          dataRowHeight: MediaQuery.of(context).size.height * 0.04,
                          headingRowColor: MaterialStateColor.resolveWith((states) => AppColor.primer),
                          dividerThickness: 1,
                          columns: [
                            _dataColumn(label: "S.No"),
                            _dataColumn(label: "Mobile Number"),
                            _dataColumn(label: "BP Number"),
                            _dataColumn(label: "Area"),
                            _dataColumn(label: "Name"),
                            //  _dataColumn(label: "Proposed Date"),
                          ],
                          rows: dataState.listOfInstallationRow
                              .mapIndexed((index, user) => DataRow(
                                      onSelectChanged: (newValue) async {
                                        await SharedPref.setString(key: PrefsValue.meterLMCFeasId, value: user.lmcFeasId!);
                                        await SharedPref.setString(key: PrefsValue.proposedDate, value: user.proposedDate!);
                                        await SharedPref.setString(key: PrefsValue.bpNumber, value: user.bpNumber!);
                                        await SharedPref.setString(key: PrefsValue.meterDma, value: user.dma!);
                                        await SharedPref.setString(key: PrefsValue.feasibilityVisitDate, value: user.feasibilityVisitDate!);
                                        await SharedPref.setString(key: PrefsValue.custRegNo, value: user.crn!);
                                        await SharedPref.setString(key: PrefsValue.chargeArea, value: user.chargeAreaName!);
                                        await SharedPref.setString(key: PrefsValue.areaName, value: user.areaName!);
                                        await SharedPref.setString(key: PrefsValue.firstName, value: user.firstName!);
                                        await SharedPref.setString(key: PrefsValue.lastName, value: user.lastName!);
                                        await SharedPref.setString(key: PrefsValue.mobileNumber, value: user.mobileNumber!);
                                        await SharedPref.setString(key: PrefsValue.buildingNumber, value: user.buildingNumber ?? "");
                                        await SharedPref.setString(key: PrefsValue.houseNumber, value: user.houseNumber ?? "");
                                        await SharedPref.setString(key: PrefsValue.locality, value: user.locality ?? "");
                                        //   await SharedPref.setString(key: PrefsValue.address2, value: user.address2 ?? "");
                                        await SharedPref.setString(key: PrefsValue.town, value: user.town!);
                                        await SharedPref.setString(key: PrefsValue.district, value: user.district!);
                                        await SharedPref.setString(key: PrefsValue.pinCode, value: user.pinCode!);
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewInstallationView()));
                                      },
                                      cells: <DataCell>[
                                        _dataCell(label: (dataState.listOfInstallationRow.indexOf(user) + 1 + (dataState.pageNo - 1) * 10).toString()),
                                        _dataCell(label: user.mobileNumber.toString()),
                                        _dataCell(label: user.bpNumber.toString()),
                                        _dataCell(label: user.areaName.toString()),
                                        _dataCell(label: user.firstName.toString()),

                                        ///  _dataCell(label: user.feasibilityVisitDate.toString()),
                                      ]))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  DataColumn _dataColumn({required String label}) {
    return DataColumn(
        label: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        label,
        style: Styles.table,
        textAlign: TextAlign.center,
      ),
    ));
  }

  DataCell _dataCell({required String label}) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
