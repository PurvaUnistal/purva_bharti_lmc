import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_bloc.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_event.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/MeterInstallation/domain/bloc/meter_installation_state.dart';
import 'package:lmc/features/LMC%20Installation/Meter%20Installation/PreviewMeterInstallation/presenation/preview_meter_installation_view.dart';

class MeterInstallationView extends StatefulWidget {
  const MeterInstallationView({super.key});

  @override
  State<MeterInstallationView> createState() => _MeterInstallationViewState();
}

class _MeterInstallationViewState extends State<MeterInstallationView> {
  @override
  void initState() {
    BlocProvider.of<NetworkBloc>(context)
        .add(NetworkObserveEvent(context: context));
    BlocProvider.of<MeterInstallationBloc>(context).add(MeterInstallationPageLoadEvent(context: context));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MeterInstallationBloc, MeterInstallationState>(
        builder: (context, state) {
          if (state is MeterInstallationDataState) {
            return _itemBuilder(dataState: state);
          } else {
            return const Center(
              child: SpinLoader(),
            );
          }
        },
      ),
    );
  }

  Widget _itemBuilder({required MeterInstallationDataState dataState}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
      child: Column(
        children: [
          _verticalSpace(),
          _areaDropDown(dataState: dataState),
          _verticalSpace(),
          _searchTextField(dataState: dataState),
          _verticalSpace(),
          Flexible(child: _dataTableWidget(dataState: dataState)),
        ],
      ),
    );
  }

  Widget _areaDropDown({required MeterInstallationDataState dataState}) {
    return DropdownWidget(
      label: "Select Area",
      hint: "Select Area",
      dropdownValue: dataState.allAreaValue == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<MeterInstallationBloc>(context).add(SelectAreaValueEvent(
          allAreaValue: newVal,
        ));
      },
    );
  }

  Widget _searchTextField({required MeterInstallationDataState dataState}) {
    return TextFieldWidget(
      label: "Search",
      hintText: "Search",
      // controller: dataState.bpNumberController,
      keyboardType: TextInputType.text,
      suffixIcon: Icon(
        Icons.search_rounded,
        color: Colors.green.shade800,
      ),
      onChanged: (val) {
        BlocProvider.of<MeterInstallationBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required MeterInstallationDataState dataState}) {
    var h = MediaQuery.of(context).size.height * 0.20;
    return dataState.installationDoneModel?.data?.pager?.total == 0 ? Center(child: Text("No Data Found",style: Styles.labels,)):dataState.isLoadingMore == true
        ? SizedBox(height: h * 0.7, child: SpinLoader())
        :  dataState.listOfInstallationRow.isEmpty
        ? Center(child: Text("No Data Found",style: Styles.labels,)) :SingleChildScrollView(
            controller: dataState.scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.green[800]),
                child: DataTable(
                  sortAscending: true,
                  columnSpacing: 12,
                  horizontalMargin: 0,
                  showCheckboxColumn: false,
                  headingRowColor: MaterialStateColor.resolveWith((states) => AppColor.primer),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                                await SharedPref.setString(key: PrefsValue.bpNumber, value: user.bpNumber!);
                                await SharedPref.setString(key: PrefsValue.meterDma, value: user.dma!);
                                await SharedPref.setString(key: PrefsValue.feasibilityVisitDate, value: user.feasibilityVisitDate!);
                                await SharedPref.setString(key: PrefsValue.custRegNo, value: user.crn!);
                                await SharedPref.setString(key: PrefsValue.areaName, value: user.areaName!);
                                await SharedPref.setString(key: PrefsValue.firstName, value: user.firstName!);
                                await SharedPref.setString(key: PrefsValue.lastName, value: user.lastName!);
                                await SharedPref.setString(key: PrefsValue.guardianName, value: user.guardianName!);
                                await SharedPref.setString(key: PrefsValue.proCateName, value: user.propName!);
                                await SharedPref.setString(key: PrefsValue.propClass, value: user.propClass!);
                                await SharedPref.setString(key: PrefsValue.buildingNumber, value: user.buildingNumber!);
                                await SharedPref.setString(key: PrefsValue.houseNumber, value: user.houseNumber!);
                                await SharedPref.setString(key: PrefsValue.locality, value: user.locality!);
                                await SharedPref.setString(key: PrefsValue.locality, value: user.state!);
                                await SharedPref.setString(key: PrefsValue.town, value: user.town!);
                                await SharedPref.setString(key: PrefsValue.district, value: user.district!);
                                await SharedPref.setString(key: PrefsValue.pinCode, value: user.pinCode!);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewMeterInstalView()));
                              },
                              cells: <DataCell>[
                                _dataCell(label:(dataState.listOfInstallationRow.indexOf(user) + 1 + (dataState.pageNo - 1) * 10).toString()),
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
          );
  }

  DataColumn _dataColumn({required String label}) {
    return DataColumn(label: Text(label, style: Styles.table));
  }

  DataCell _dataCell({required String label}) {
    return DataCell(Text(label ?? ""));
  }

  Widget _verticalSpace() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.02,
    );
  }
}
