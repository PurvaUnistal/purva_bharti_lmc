import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/WidgetStyles/common_style.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/pop_two_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/NGC/NGCForm/presentation/ngc_form_view.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_event.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_state.dart';

class NgcTableView extends StatefulWidget {
  @override
  _NgcTableViewState createState() => _NgcTableViewState();
}

class _NgcTableViewState extends State<NgcTableView> {
  ScrollController _horizontalScrollController = ScrollController();
  ScrollController _verticalScrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NgcTableBloc>(context).add(NgcTablePageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.green50,
      body: BlocBuilder<NgcTableBloc, NgcTableState>(
        builder: (context, state) {
          if (state is FetchNgcTableDataState) {
            return  BackgroundWidget(
              child: _buildLayout(dataState: state,),
            );
          } else {
            return const Center(
              child: SpinLoader(),
            );
          }
        },
      ),
      //  body: _bodyNoBloc(),
    );
  }

  _buildLayout({required FetchNgcTableDataState dataState}) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppString.ngConH,
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
          Text("Click on row to open NG Conversion Form", style: Styles.labels,),
          Flexible(child: Padding(
            padding: const EdgeInsets.only(bottom: 18.0),
            child: _dataTableWidget(dataState: dataState),
          )),
        ],
      ),
    );
  }

  Widget _areaDropDown({required FetchNgcTableDataState dataState}) {
    return DropdownWidget<GetAllAreaModel>(
      label: AppString.selectArea,
      hint: AppString.selectArea,
      dropdownValue: dataState.allAreaValue == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<NgcTableBloc>(context).add(SelectAreaValueEvent(
          allAreaValue: newVal!,
          context: context,
        ));
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
        onPressed: (){},
      ),
      onChanged: (val) {
        BlocProvider.of<NgcTableBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required FetchNgcTableDataState dataState}) {
    return dataState.isAreaFilter == false
        ? dataState.lmcInstallationByNgcModel?.success == 400
        ? Center(child: Text("No records found"))
        :Theme(
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
                  data: Theme.of(context).copyWith(dividerColor: Colors.green[800]),
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
                      CommonStyle.dataColumn(label: "S.No"),
                      CommonStyle.dataColumn(label: "Ready for NGC"),
                      CommonStyle.dataColumn(label: "Mobile Number"),
                      CommonStyle.dataColumn(label: "BP Number"),
                      CommonStyle.dataColumn(label: "Area"),
                      CommonStyle.dataColumn(label: "First Name"),
                      CommonStyle.dataColumn(label: "Installation Date"),
                    ],
                    rows: dataState.listOfFilterInstallationByNgc.mapIndexed((index, user) =>
                        DataRow(
                            onSelectChanged: (newValue) async {
                              await SharedPref.setString(
                                  key: PrefsValue.dmaUserId, value: user.dmaUserId ?? "");
                              await SharedPref.setString(
                                  key: PrefsValue.lmcInstallationId, value: user
                                  .lmcInstallationId ?? "");
                              await SharedPref.setString(
                                  key: PrefsValue.isInstall, value: user.isInstall ??
                                  "");
                              await SharedPref.setString(
                                  key: PrefsValue.bpNumber, value: user.bpNumber ??
                                  "");
                              await SharedPref.setString(
                                  key: PrefsValue.meterReading, value: user
                                  .meterreading ?? "");
                              await SharedPref.setString(key: PrefsValue.meterNumberId, value: user.meterNumber ?? "");
                              await SharedPref.setString(key: PrefsValue.meterNumberSerial, value: user.meterSerial ?? "");
                              await SharedPref.setString(
                                  key: PrefsValue.mobileNumber, value: user.mobileNumber ?? "");
                              await SharedPref.setString(key: PrefsValue.alternateMobileNo, value: user.alternateMobileNo ?? "");
                              await SharedPref.setString(key: PrefsValue.email, value: user.email ?? "");
                              await SharedPref.setString(key: PrefsValue.ngOfBurners, value: user.ngOfBurners ?? "");
                              await SharedPref.setString(key: PrefsValue.noOfFamilyMembers, value: user.dmafamily ?? "");
                              await SharedPref.setString(key: PrefsValue.workCompletedDate, value: user.workCompletedDate ?? "");
                              await SharedPref.setString(key: PrefsValue.typeOfNr, value: user.typeOfNr ?? "");
                              await SharedPref.setString(key: PrefsValue.rfcDate, value: user.rfcDate ?? "");
                              await SharedPref.setString(key: PrefsValue.lmcInstallationDate, value: user.lmcInstallationDate ?? "");
                              await SharedPref.setString(key: PrefsValue.proposedNgcDate, value: user.lmcProposedNgcDate ?? AppString.dateFormat);
                              await SharedPref.setString(key: PrefsValue.lmcPath, value: user.lmcpath!);
                              await SharedPref.setString(key: PrefsValue.meterPhoto, value: user.meterPhoto!);
                              await SharedPref.setString(key: PrefsValue.regulatorType, value: user.regulatorType!);
                              await SharedPref.setString(key: PrefsValue.regulatorTypeId, value: user.regulatorTypeId!);
                          /*    await SharedPref.setString(key: PrefsValue.srRegulatorId, value: user.regulators!);
                              await SharedPref.setString(key: PrefsValue.srRegulatorSerial, value: user.regulatorSerial!);
                              await SharedPref.setString(key: PrefsValue.mrRegulatorId, value: user.mrRegulatorId!);
                              await SharedPref.setString(key: PrefsValue.mrRegulatorSerial, value: user.mrRegulatorSerial!);*/
                              await SharedPref.setString(key: PrefsValue.srRegulatorId, value: user.mrRegulatorId!);
                              await SharedPref.setString(key: PrefsValue.srRegulatorSerial, value: user.mrRegulatorSerial!);
                              await SharedPref.setString(key: PrefsValue.mrRegulatorId, value: user.regulators!);
                              await SharedPref.setString(key: PrefsValue.mrRegulatorSerial, value: user.regulatorSerial!);
                              await SharedPref.setString(key: PrefsValue.regulatorCheck, value: user.regulatorCheck!);
                              await SharedPref.setString(key: PrefsValue.rfcPhoto, value: user.rfcForm!);
                              await SharedPref.setString(key: PrefsValue.pneumaticPhoto, value: user.pneumaticImage!);
                              await SharedPref.setString(key: PrefsValue.extraPipe, value: user.extraPipe!);
                              await SharedPref.setString(key: PrefsValue.extraPrice, value: user.extraPrice!);
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => NGCFormView()));
                            },
                            cells: <DataCell>[
                              CommonStyle.dataCell(label: (dataState.listOfFilterInstallationByNgc
                                  .indexOf(user) + 1 + (dataState.pageNo - 1) * 10)
                                  .toString()),
                              CommonStyle.dataCellG(label: "Yes"),
                              CommonStyle.dataCell(label: user.mobileNumber.toString()),
                              CommonStyle.dataCell(label: user.bpNumber.toString()),
                              CommonStyle.dataCell(label: user.areaName.toString()),
                              CommonStyle.dataCell(label: user.firstName.toString()),
                              CommonStyle.dataCell(label: user.dateOfRegistration.toString()),
                            ]))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ): Center(child: SpinLoader());
  }


  DataCell _dataCellStatus({required String label, required Color color }) {
    return DataCell(Text(label, style: Styles.status(color:color ),));
  }

}


