import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/Routes/routes_name.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/app_string.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_event.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_state.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/presenation/preview_feasibility_view.dart';
import 'package:lmc/features/Home/presentation/widget/logout_widget.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_bloc.dart';
import 'package:lmc/features/InternetConnection/domain/bloc/network_event.dart';

class FeasibilityView extends StatefulWidget {
  const FeasibilityView({super.key});

  @override
  State<FeasibilityView> createState() => _FeasibilityViewState();
}

class _FeasibilityViewState extends State<FeasibilityView> {
  @override
  void initState() {
    BlocProvider.of<NetworkBloc>(context)
        .add(NetworkObserveEvent(context: context));
    BlocProvider.of<LMCFeasibilityBloc>(context).add(LMCFeasibilityPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: RoutesName.lmcFeasibility,
        boolLeading: false,
        leadingWidget: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppString.release,style: Styles.rel,),
            Text(AppString.reDate,style: Styles.rel,),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () async {
                showModalBottomSheet(context: context, builder: (context) => const LogoutWidget());
              },
              icon: Icon(
                Icons.logout,
                color: AppColor.white,
              ))
        ],
      ),
      body: BlocBuilder<LMCFeasibilityBloc, LMCFeasibilityState>(
        builder: (context, state) {
          if (state is LMCFeasibilityDataState) {
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

  Widget _itemBuilder({required LMCFeasibilityDataState dataState}) {
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

  Widget _areaDropDown({required LMCFeasibilityDataState dataState}) {
    return DropdownWidget(
      label: "Select Area",
      hint: "Select Area",
      dropdownValue: dataState.allAreaValue == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<LMCFeasibilityBloc>(context).add(SelectAreaValueEvent(
          allAreaValue: newVal,
        ));
      },
    );
  }

  Widget _searchTextField({required LMCFeasibilityDataState dataState}) {
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
        BlocProvider.of<LMCFeasibilityBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required LMCFeasibilityDataState dataState}) {
    var h = MediaQuery.of(context).size.height * 0.20;
    return dataState.feasibilityModel?.data?.pager?.total == 0 ? Center(child: Text("No Data Found",style: Styles.labels,)):dataState.isLoadingMore == true
        ? SizedBox(height: h * 0.7, child: SpinLoader())
        : SingleChildScrollView(
            controller: dataState.scrollController,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.green[800]),
                child: DataTable(
                  showCheckboxColumn: false,
                  headingRowColor: MaterialStateColor.resolveWith((states) => AppColor.primer),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  //    dataRowHeight: 50,
                  dividerThickness: 1,
                  columns: [
                    _dataColumn(label: "S.No"),
                    _dataColumn(label: "BP Number"),
                    _dataColumn(label: "Installation Date"),
                    _dataColumn(label: "Conversion date"),
                    _dataColumn(label: "Area"),
                    _dataColumn(label: "Mobile Number"),
                    _dataColumn(label: "First Name"),
                    _dataColumn(label: "Surname"),
                    _dataColumn(label: "Property Category"),
                    _dataColumn(label: "Property Class"),
                    _dataColumn(label: "House Number"),
                    _dataColumn(label: "Locality"),
                  ],
                  //listOfFeasibilityRow ye list h
                  rows: dataState.listOfFeasibilityRow
                      .mapIndexed((index, user) => DataRow(
                              onSelectChanged: (newValue) async {
                                await SharedPref.setString(key: PrefsValue.lmcId, value: user.lmcId!);
                                await SharedPref.setString(key: PrefsValue.dma, value: user.dma!);
                                await SharedPref.setString(key: PrefsValue.bpNumber, value: user.bpNumber!);
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PreviewFeasibilityView()));
                              },
                              cells: <DataCell>[
                                _dataCell(label: "${index + 1}"),
                                _dataCell(label: user.bpNumber.toString()),
                                _dataCell(label: user.dateOfRegistration.toString()),
                                _dataCell(label: user.conversionDate.toString()),
                                _dataCell(label: user.areaName.toString()),
                                _dataCell(label: user.mobileNumber.toString()),
                                _dataCell(label: user.firstName.toString()),
                                _dataCell(label: user.lastName.toString()),
                                _dataCell(label: user.propName.toString()),
                                _dataCell(label: user.propClass.toString()),
                                _dataCell(label: user.houseNumber.toString()),
                                _dataCell(label: user.locality.toString()),
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
