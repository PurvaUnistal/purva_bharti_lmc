import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:lmc/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/icon_button.dart';
import 'package:lmc/Utils/common_widgets/pop_two_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_bar_widget.dart';
import 'package:lmc/Utils/common_widgets/res/app_color.dart';
import 'package:lmc/Utils/common_widgets/res/app_string.dart';
import 'package:lmc/Utils/common_widgets/res/app_styles.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/Feasibility/LMC%20Feasibility/domain/model/GetAllAreaModel.dart';
import 'package:lmc/features/Home/presentation/widget/logout_widget.dart';
import 'package:lmc/features/NGC/NGCForm/presentation/ngc_form_view.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_bloc.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_event.dart';
import 'package:lmc/features/NGC/NGCTable/domain/bloc/ngc_table_state.dart';

class NgcTableView extends StatefulWidget {
  @override
  _NgcTableViewState createState() => _NgcTableViewState();
}

class _NgcTableViewState extends State<NgcTableView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NgcTableBloc>(context).add(NgcTablePageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Scaffold(
        appBar: AppBarWidget(
          title: "NGC",
          boolLeading: false,
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
          body: BlocBuilder<NgcTableBloc, NgcTableState>(
            builder: (context, state) {
              if (state is FetchNgcTableDataState) {
                return _buildLayout(dataState: state);
              } else {
                return const Center(
                  child: SpinLoader(),
                );
              }
            },
          ),
        //  body: _bodyNoBloc(),
      ),
    );
  }

  _buildLayout({required FetchNgcTableDataState dataState}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("${AppString.release}: ${AppString.reDate}",style: Styles.rel,),
            // Text("${AppString.scheme}: ${dataState.scheme}, ${AppString.userName}: ${dataState.userName}",style: Styles.rel,),
          ],
        ),
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
        Flexible(child: _dataTableWidget(dataState: dataState)),
      ],
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
      suffixIcon:IconButtonWidget(iconData:  Icons.search_rounded,onPressed:(){}),
      onChanged: (val) {
        BlocProvider.of<NgcTableBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }
  Widget _dataTableWidget({required FetchNgcTableDataState dataState}) {
    return dataState.lmcInstallationByNgcModel?.success == 400
        ? Center(child: Text("No records found"))
        : SingleChildScrollView(
      child: SingleChildScrollView(
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
              _dataColumn(label: "Status"),
              _dataColumn(label: "BP Number"),
              _dataColumn(label: "Installation Date"),
              _dataColumn(label: "Area"),
              _dataColumn(label: "Mobile Number"),
              _dataColumn(label: "First Name"),
              _dataColumn(label: "Surname"),
              /*_dataColumn(label: "Property Category"),
              _dataColumn(label: "Property Class"),
              _dataColumn(label: "House Number"),
              _dataColumn(label: "Locality"),*/
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
                          key: PrefsValue.mobileNumber, value: user
                          .mobileNumber ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.alternateMobileNo, value: user
                          .alternateMobileNo ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.email, value: user.email ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.ngOfBurners, value: user
                          .ngOfBurners ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.workCompletedDate, value: user
                          .workCompletedDate ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.ngChargeDate, value: user
                          .ngChargeDate ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.buildingNumber, value: user
                          .buildingNumber ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.houseNumber, value: user
                          .houseNumber ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.locality, value: user.locality ??
                          "");
                      await SharedPref.setString(
                          key: PrefsValue.address2, value: user.address2 ??
                          "");
                      await SharedPref.setString(
                          key: PrefsValue.state, value: user.state ?? "");
                      await SharedPref.setString(
                          key: PrefsValue.town, value: user.town ?? "");
                      await SharedPref.setString(key: PrefsValue.district, value: user.district ?? "");
                      await SharedPref.setString(key: PrefsValue.pinCode, value: user.pinCode ?? "");
                      await SharedPref.setString(key: PrefsValue.delayReason, value: user.delayReason ?? "");
                      await SharedPref.setString(key: PrefsValue.typeOfNr, value: user.typeOfNr ?? "");
                      await SharedPref.setString(key: PrefsValue.latitudeTf, value: user.latitudeTf ?? "");
                      await SharedPref.setString(key: PrefsValue.longitudeTf, value: user.longitudeTf ?? "");
                      await SharedPref.setString(key: PrefsValue.latitudeHg, value: user.latitudeHg ?? "");
                      await SharedPref.setString(key: PrefsValue.longitudeHg, value: user.longitudeHg ?? "");
                      await SharedPref.setString(key: PrefsValue.rfcDate, value: user.rfcDate ?? "");
                      //////////////////////
                      if (user.interested == "0") {
                        if (user.futureRegNgcEligibleStatus == "1") {
                          if (user.paymentCreditStatus == "1") {
                            if (user.depositAmountBeforeNgc == "0") {
                              print("Enable");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NGCFormView()));
                            } else {
                              if (user.ngcStatus == "1") {
                                if (user.paymentCreditStatusNgc == '1') {
                                  print("Enable");
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
                              print("Enable");
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
                              _dataCellIcon(label: "Enable."),
                            ]else...[
                              if(user.ngcStatus == "1")...[
                                if(user.paymentCreditStatusNgc == "1")...[
                                  _dataCellIcon(label: "Enable."),
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
                          _dataCellIcon(label: "Enable."),
                        ]else...[
                          if(user.ngcStatus == "1")...[
                            if(user.paymentCreditStatusNgc == "1")...[
                              _dataCellIcon(label: "Enable."),
                            ]else...[
                              _dataCellStatus(label: "Gas Deposit Payment Pending.", color: AppColor.blue)
                            ],
                          ] else...[
                            _dataCellStatus(label: "Pending.", color: AppColor.primer1)
                          ],
                        ]
                      ],
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
      child: Text(label),
    ));
  }
  DataCell _dataCellStatus({required String label, required Color color }) {
    return DataCell(Text(label, style: Styles.status(color:color ),));
  }
  DataCell _dataCellIcon({required String label}) {
    return DataCell(Row(
      children: [
        Icon(Icons.edit, color: AppColor.primer,size: 15,),
        Text(label, style: Styles.title,),
      ],
    ));
  }
  _verticalSpace() {
    return SizedBox(height: MediaQuery.of(context).size.height * 0.01);
  }
}


