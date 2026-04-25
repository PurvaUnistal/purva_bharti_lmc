import 'package:collection/collection.dart';
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
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_bloc.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_event.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/bloc/lmc_feasibility_state.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Feasibility/PreviewFeasibility/presenation/preview_feasibility_view.dart';

class FeasibilityView extends StatefulWidget {
  const FeasibilityView({super.key});

  @override
  State<FeasibilityView> createState() => _FeasibilityViewState();
}

class _FeasibilityViewState extends State<FeasibilityView> {
  ScrollController _horizontalScrollController = ScrollController();
  ScrollController _verticalScrollController = ScrollController();

  @override
  void initState() {
    BlocProvider.of<LMCFeasibilityBloc>(
      context,
    ).add(LMCFeasibilityPageLoadEvent(context: context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBarWidget(title: AppString.lmcFeaH, boolLeading: true),
      body: BackgroundWidget(
        child: BlocBuilder<LMCFeasibilityBloc, LMCFeasibilityState>(
          builder: (context, state) {
            if (state is LMCFeasibilityDataState) {
              return _itemBuilder(dataState: state);
            } else {
              return const Center(child: SpinLoader());
            }
          },
        ),
      ),
    );
  }

  Widget _itemBuilder({required LMCFeasibilityDataState dataState}) {
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
            "Click on row to open Feasibility Form",
            style: Styles.labels,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18.0),
              child: _dataTableWidget(dataState: dataState),
            ),
          ),
        ],
      );
  }

  Widget _areaDropDown({required LMCFeasibilityDataState dataState}) {
    return DropdownWidget<GetAllAreaModel>(
      label: AppString.area,
      hint: AppString.area,
      dropdownValue:
          dataState.allAreaValue.gid != null ? dataState.allAreaValue : null,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<LMCFeasibilityBloc>(
          context,
        ).add(SelectAreaValueEvent(allAreaValue: newVal!, context: context));
      },
    );
  }

  Widget _searchTextField({required LMCFeasibilityDataState dataState}) {
    return TextFieldWidget(
      label: AppString.searchBPNumber,
      hintText: AppString.searchBPNumber,
      controller: dataState.bpNumberController,
      keyboardType: TextInputType.number,
      maxLength: 15,
      suffixIcon: IconButtonWidget(
        iconData: Icons.search_rounded,
        onPressed: () {},
      ),
      onChanged: (val) {
        BlocProvider.of<LMCFeasibilityBloc>(
          context,
        ).add(SearchBpNumberEvent(context: context, searchBpNumber: val));
      },
    );
  }

  Widget _dataTableWidget({required LMCFeasibilityDataState dataState}) {
    return dataState.isAreaFilter == false
        ? dataState.feasibilityModel.success == 400
            ? Center(child: Text("No records found"))
            : Theme(
              data: ThemeData(highlightColor: EnvironmentConfig.of(context)!.secondaryTheme),
              child: Scrollbar(
                controller: _verticalScrollController,
                thickness: 3.0,
                scrollbarOrientation: ScrollbarOrientation.right,
                thumbVisibility: true,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  controller: _verticalScrollController,
                  child: Theme(
                    data: ThemeData(highlightColor: EnvironmentConfig.of(context)!.secondaryTheme),
                    child: Scrollbar(
                      controller: _horizontalScrollController,
                      thickness: 3.0,
                      scrollbarOrientation: ScrollbarOrientation.top,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: _horizontalScrollController,
                        scrollDirection: Axis.horizontal,
                        child: Theme(
                          data: Theme.of(
                            context,
                          ).copyWith(dividerColor: EnvironmentConfig.of(context)!.primaryTheme),
                          child: DataTable(
                            sortAscending: true,
                            columnSpacing: 0,
                            horizontalMargin: 0,
                            showCheckboxColumn: false,
                            dataTextStyle: Styles.texts,
                            dataRowHeight:
                                MediaQuery.of(context).size.height * 0.04,
                            headingRowColor: MaterialStateColor.resolveWith(
                              (states) => EnvironmentConfig.of(context)!.primaryTheme,
                            ),
                            dividerThickness: 1,
                            columns: [
                              CommonStyle.dataColumn(label: "S.No"),
                              CommonStyle.dataColumn(label: "Mobile Number"),
                              CommonStyle.dataColumn(label: "BP Number"),
                              CommonStyle.dataColumn(label: "Area"),
                              CommonStyle.dataColumn(label: "Name"),
                            ],
                            rows:
                                dataState.listOfFilterFeasibilityRow
                                    .mapIndexed(
                                      (index, user) => DataRow(
                                        onSelectChanged: (newValue) async {
                                          await SharedPref.setString(
                                            key: PrefsValue.assignLmcDate,
                                            value: user.assignLmcDate ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.crNumber,
                                            value: user.crn ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.proposedDate,
                                            value: user.proposedDate ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.lmcId,
                                            value: user.lmcId ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.assignId,
                                            value: user.assignId ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.dma,
                                            value: user.dma ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.bpNumber,
                                            value: user.bpNumber ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.chargeArea,
                                            value: user.chargeAreaName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.areaName,
                                            value: user.areaName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.firstName,
                                            value: user.firstName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.lastName,
                                            value: user.lastName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.mobileNumber,
                                            value: user.mobileNumber ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.guardianName,
                                            value: user.guardianName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.proCateName,
                                            value: user.propName ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.propClass,
                                            value: user.propClass ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.buildingNumber,
                                            value: user.buildingNumber ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.houseNumber,
                                            value: user.houseNumber ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.locality,
                                            value: user.locality ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.address2,
                                            value: user.address2 ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.state,
                                            value: user.state ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.town,
                                            value: user.town ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.district,
                                            value: user.district ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.pinCode,
                                            value: user.pinCode ?? "",
                                          );
                                          await SharedPref.setString(
                                            key: PrefsValue.propertyCategoryId,
                                            value: user.propertyCategoryId!,
                                          );
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) =>
                                                      PreviewFeasibilityView(),
                                            ),
                                          );
                                        },
                                        cells: <DataCell>[
                                          CommonStyle.dataCell(
                                            label:
                                                (dataState.listOfFilterFeasibilityRow
                                                            .indexOf(user) +
                                                        1 +
                                                        (dataState.pageNo - 1) *
                                                            10)
                                                    .toString(),
                                          ),
                                          CommonStyle.dataCell(
                                            label: user.mobileNumber.toString(),
                                          ),
                                          CommonStyle.dataCell(
                                            label: user.bpNumber.toString(),
                                          ),
                                          CommonStyle.dataCell(
                                            label: user.areaName.toString(),
                                          ),
                                          CommonStyle.dataCell(
                                            label: user.firstName.toString(),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
        : Center(child: SpinLoader());
  }
}
