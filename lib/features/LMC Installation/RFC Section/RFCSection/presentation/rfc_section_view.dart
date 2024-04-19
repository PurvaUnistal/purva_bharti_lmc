import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lmc/Utils/common_widgets/Loader/SpinLoader.dart';
import 'package:collection/collection.dart';
import 'package:lmc/Utils/common_widgets/app_color.dart';
import 'package:lmc/Utils/common_widgets/dropdown_widget.dart';
import 'package:lmc/Utils/common_widgets/styles_widget.dart';
import 'package:lmc/Utils/common_widgets/text_form_widget.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_bloc.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_event.dart';
import 'package:lmc/features/LMC%20Installation/RFC%20Section/RFCSection/domain/bloc/rfc_section_state.dart';

class RFCSectionView extends StatefulWidget {
  const RFCSectionView({super.key});

  @override
  State<RFCSectionView> createState() => _RFCSectionViewState();
}

class _RFCSectionViewState extends State<RFCSectionView> {

  @override
  void initState() {
    super.initState();
    BlocProvider.of<RFCSectionBloc>(context).add(RFCSectionPageLoadEvent(context: context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  BlocBuilder<RFCSectionBloc, RFCSectionState>(
        builder: (context, state) {
          if (state is RFCSectionDataState) {
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
  Widget _itemBuilder({required RFCSectionDataState dataState}) {
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

  Widget _areaDropDown({required RFCSectionDataState dataState}) {
    return DropdownWidget(
      label: "Select Area",
      hint: "Select Area",
      dropdownValue: dataState.allAreaValue == null ? null : dataState.allAreaValue,
      items: dataState.listOfAllArea,
      onChanged: (newVal) {
        BlocProvider.of<RFCSectionBloc>(context).add(SelectAreaValueEvent(
          allAreaValue: newVal,
        ));
      },
    );
  }

  Widget _searchTextField({required RFCSectionDataState dataState}) {
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
        BlocProvider.of<RFCSectionBloc>(context).add(SearchBpNumberEvent(
          context: context,
          searchBpNumber: val,
        ));
      },
    );
  }

  Widget _dataTableWidget({required RFCSectionDataState dataState}) {
    var h = MediaQuery.of(context).size.height * 0.20;
    return dataState.isLoadingMore == true ? SizedBox(
        height: h * 0.7,
        child: SpinLoader()):SingleChildScrollView(
      controller: dataState.scrollController,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.green[800]),
          child:DataTable(
            showCheckboxColumn: false,
            headingRowColor: MaterialStateColor.resolveWith(
                    (states) => AppColor.primer),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),),
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
            rows: dataState.listOfFeasibilityRow
                .mapIndexed((index, user) => DataRow(
                cells: <DataCell>[
                  _dataCell(label: "${index + 1}"),
                  _dataCell(label: user.bpNumber.toString()),
                  _dataCell(
                      label: user.dateOfRegistration.toString()),
                  _dataCell(
                      label: user.conversionDate.toString()),
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

