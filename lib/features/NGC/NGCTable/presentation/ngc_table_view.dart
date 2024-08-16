import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/background_widget.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
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
                _verticalSpace(),
                _areaDropDown(dataState: dataState),
                _verticalSpace(),
                _searchTextField(dataState: dataState),
              ],
            ),
          ),
          _verticalSpace(),
          Text("Click on row to open NG Conversion Form", style: Styles.labels,),
          Flexible(child: _dataTableWidget(dataState: dataState)),
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
      label: AppString.search,
      hintText: AppString.search,
      controller: dataState.bpNumberController,
      keyboardType: TextInputType.number,
      maxLength: 10,
      suffixIcon: Icon(
        Icons.search_rounded,
        color: Colors.green.shade800,
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
    var h = MediaQuery.of(context).size.height * 0.20;
    return dataState.lmcInstallationByNgcModel?.success == 400
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
                    headingRowColor: MaterialStateColor.resolveWith((states) => AppColor.primer),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    dividerThickness: 1,
                    columns: [
                      _dataColumn(label: "S.No"),
                      _dataColumn(label: "Ready for NGC"),
                      _dataColumn(label: "BP Number"),
                      _dataColumn(label: "Installation Date"),
                      _dataColumn(label: "Area"),
                      _dataColumn(label: "Mobile Number"),
                      _dataColumn(label: "First Name"),
                      _dataColumn(label: "Surname"),
                    ],
                    rows: dataState.listOfInstallationByNgc.mapIndexed((index, user) =>
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
                              await SharedPref.setString(
                                  key: PrefsValue.meterSerial, value: user
                                  .meterSerial ?? "");
                              await SharedPref.setString(
                                  key: PrefsValue.mobileNumber, value: user.mobileNumber ?? "");
                              await SharedPref.setString(key: PrefsValue.alternateMobileNo, value: user.alternateMobileNo ?? "");
                              await SharedPref.setString(key: PrefsValue.email, value: user.email ?? "");
                              await SharedPref.setString(key: PrefsValue.ngOfBurners, value: user.ngOfBurners ?? "");
                              await SharedPref.setString(key: PrefsValue.ngOfBurners, value: user.noOfFamilyMembers ?? "");
                              await SharedPref.setString(key: PrefsValue.workCompletedDate, value: user.workCompletedDate ?? "");
                              await SharedPref.setString(key: PrefsValue.ngChargeDate, value: user.ngChargeDate ?? "");
                              await SharedPref.setString(key: PrefsValue.buildingNumber, value: user.buildingNumber ?? "");
                              await SharedPref.setString(key: PrefsValue.houseNumber, value: user.houseNumber ?? "");
                              await SharedPref.setString(key: PrefsValue.locality, value: user.locality ?? "");
                              await SharedPref.setString(key: PrefsValue.address2, value: user.address2 ?? "");
                              await SharedPref.setString(key: PrefsValue.state, value: user.state ?? "");
                              await SharedPref.setString(key: PrefsValue.town, value: user.town ?? "");
                              await SharedPref.setString(key: PrefsValue.district, value: user.district ?? "");
                              await SharedPref.setString(key: PrefsValue.pinCode, value: user.pinCode ?? "");
                              await SharedPref.setString(key: PrefsValue.delayReason, value: user.delayReason ?? "");
                              await SharedPref.setString(key: PrefsValue.typeOfNr, value: user.typeOfNr ?? "");
                              await SharedPref.setString(key: PrefsValue.latitudeTf, value: user.latitudeTf ?? "");
                              await SharedPref.setString(key: PrefsValue.longitudeTf, value: user.longitudeTf ?? "");
                              await SharedPref.setString(key: PrefsValue.latitudeHg, value: user.latitudeHg ?? "");
                              await SharedPref.setString(key: PrefsValue.longitudeHg, value: user.longitudeHg ?? "");
                              await SharedPref.setString(key: PrefsValue.rfcDate, value: user.rfcDate ?? "");
                              await SharedPref.setString(key: PrefsValue.lmcInstallationDate, value: user.lmcInstallationDate ?? "");
                              await SharedPref.setString(key: PrefsValue.proposedNgcDate, value: user.lmcProposedNgcDate ?? AppString.dateFormat);
                              //////////////////////
                              if (user.interested == "0") {
                                if (user.futureRegNgcEligibleStatus == "1") {
                                  if (user.paymentCreditStatus == "1") {
                                    if (user.depositAmountBeforeNgc == "0") {
                                      print("Yes");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NGCFormView()));
                                    } else {
                                      if (user.ngcStatus == "1") {
                                        if (user.paymentCreditStatusNgc == '1') {
                                          print("Yes");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      NGCFormView()));
                                        } else {
                                          return showDialog(
                                              context: context,
                                              builder: (BuildContext mContext) =>
                                                  PopTwoBtnWidget(
                                                      message: "Gas Deposit Payment Pending.",
                                                      okButtonText: "Ok",
                                                      onPressed: () =>
                                                          Navigator.of(context).pop(
                                                              false)
                                                  ));
                                        }
                                      } else {
                                        return showDialog(
                                            context: context,
                                            builder: (BuildContext mContext) =>
                                                PopTwoBtnWidget(
                                                    message: "Pending",
                                                    okButtonText: "Ok",
                                                    onPressed: () =>
                                                        Navigator.of(context).pop(
                                                            false)
                                                ));
                                      }
                                    }
                                  } else {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext mContext) =>
                                            PopTwoBtnWidget(
                                                message: "Pending",
                                                okButtonText: "Ok",
                                                onPressed: () =>
                                                    Navigator.of(context).pop(false)
                                            ));
                                  }
                                } else {
                                  return showDialog(
                                      context: context,
                                      builder: (BuildContext mContext) =>
                                          PopTwoBtnWidget(
                                              message: "Future Registration Payment Pending.",
                                              okButtonText: "Ok",
                                              onPressed: () =>
                                                  Navigator.of(context).pop(false)
                                          ));
                                }
                              } else {
                                if (user.depositAmountBeforeNgc == "0") {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => NGCFormView()));
                                } else {
                                  if (user.ngcStatus == "1") {
                                    if (user.paymentCreditStatusNgc == "1") {
                                      print("Yes");
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NGCFormView()));
                                    } else {
                                      print("Payment Pending");
                                      return showDialog(
                                          context: context,
                                          builder: (BuildContext mContext) =>
                                              PopTwoBtnWidget(
                                                  message: "Gas Deposit Payment Pending.",
                                                  okButtonText: "Ok",
                                                  onPressed: () =>
                                                      Navigator.of(context).pop(false)
                                              ));
                                    }
                                  } else {
                                    return showDialog(
                                        context: context,
                                        builder: (BuildContext mContext) =>
                                            PopTwoBtnWidget(
                                                message: "Pending",
                                                okButtonText: "Ok",
                                                onPressed: () =>
                                                    Navigator.of(context).pop(false)
                                            ));
                                  }
                                }
                              }
                              //////////////////////////////
                            },
                            cells: <DataCell>[
                              _dataCell(label: (dataState.listOfInstallationByNgc
                                  .indexOf(user) + 1 + (dataState.pageNo - 1) * 10)
                                  .toString()),
                              ///////////////////
                              if(user.interested == "0")...[
                                if(user.futureRegNgcEligibleStatus == "1")...[
                                  if(user.paymentCreditStatus == "1")...[
                                    if(user.depositAmountBeforeNgc == "0")...[
                                      _dataCellIcon(label: "Yes"),
                                    ]else...[
                                      if(user.ngcStatus == "1")...[
                                        if(user.paymentCreditStatusNgc == "1")...[
                                          _dataCellIcon(label: "Yes"),
                                        ]else...[
                                          _dataCellStatus(label: "Gas Deposit Payment Pending.", color: AppColor.blue),
                                        ]
                                      ]else...[
                                        _dataCellStatus(label: "Pending.", color: AppColor.primer1),
                                      ]
                                    ]
                                  ]else...[
                                    _dataCellStatus(label: "Pending.", color: AppColor.primer1)
                                  ]
                                ]else...[
                                  _dataCellStatus(label: "Future Registration Payment Pending.", color: AppColor.red)
                                ]
                              ]else...[
                                if(user.depositAmountBeforeNgc == "0")...[
                                  _dataCellIcon(label: "Yes"),
                                ]else...[
                                  if(user.ngcStatus == "1")...[
                                    if(user.paymentCreditStatusNgc == "1")...[
                                      _dataCellIcon(label: "Yes"),
                                    ]else...[
                                      _dataCellStatus(label: "Gas Deposit Payment Pending.", color: AppColor.blue)
                                    ],
                                  ] else...[
                                    _dataCellStatus(label: "Pending.", color: AppColor.primer1)
                                  ],
                                ]
                              ],
                              ///////////////////
                              ///////////////////
                              _dataCell(label: user.bpNumber.toString()),
                              _dataCell(
                                  label: user.dateOfRegistration.toString()),
                              _dataCell(label: user.areaName.toString()),
                              _dataCell(label: user.mobileNumber.toString()),
                              _dataCell(label: user.firstName.toString()),
                              _dataCell(label: user.lastName.toString()),
                              /*_dataCell(label: user.propName.toString()),
                              _dataCell(label: user.propClass.toString()),
                              _dataCell(label: user.houseNumber.toString()),
                              _dataCell(label: user.locality.toString()),*/
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
    return DataColumn(label: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(label, style: Styles.table),
    ));
  }

  DataCell _dataCell({required String label}) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(label, style: Styles.texts,),
    ));
  }
  DataCell _dataCellStatus({required String label, required Color color }) {
    return DataCell(Text(label, style: Styles.status(color:color ),));
  }
  DataCell _dataCellIcon({required String label}) {
    return DataCell(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(label, style: Styles.title,),
    ));
  }
  _verticalSpace() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  }
}


