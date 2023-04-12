// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:lmc/model/api_reponse.dart';
// import 'package:lmc/model/free_material.dart';
// import 'package:lmc/model/hpcl_labels.dart';
// import 'package:lmc/model/lmc_model.dart';
// import 'package:lmc/screens/form_feasibility.dart';
// import 'package:lmc/screens/installation_screen.dart';
// import 'package:lmc/style/text_style.dart';
// import 'package:lmc/utils/global_constant.dart';
// import 'package:progress_dialog/progress_dialog.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
//
// class LmcListItem extends StatefulWidget{
//   final Rows rows;
//   const LmcListItem({Key key,this.rows}):super(key:key);
//   @override
//   State<StatefulWidget> createState() {
//    return new _LmcListItemState();
//   }
// }
//
// class _LmcListItemState extends State<LmcListItem>{
//
//   List<DropdownMenuItem<MaterialData>> _materialDropdownItems;
//   MaterialData _materialName;
//   String _materialId;
//   TextEditingController qtyController = TextEditingController();
//   String _numberValue='0';
//   List<MaterialItem> _materialList=[];
//
//   ProgressDialog pr;
//
//   String _firstNameLabel='',_middleNameLabel='',_lastNameLabel='',_customerRegNoLabel='';
//   String _lmcFeasibilityDateLabel='',_lmcProposedDateLabel='',_areaLabel='',_mobileNoLabel='';
//   String _guardianNameLabel='',_emailIdLabel='',_propertyCategoryNameLabel='',_propertyCategoryClassLabel='';
//   String _houseNoLabel='',_localityLabel='',_townLabel='',_stateLabel='',_districtLabel='';
//   String _pinCodeLabel='',_additionalLabel='',_qtyLabel='',_materialLabel='';
//
//   Future<void> _getLabelsData() async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var res =prefs.get(GlobalConstants.HpclLabels??'');
//
//     if(res== '') {
//       var _res = await http.get( (GlobalConstants.getLabels));
//       res = _res.body;
//     }
//
//     HpclLabel hpclLabel         = HpclLabel.fromJson(json.decode(res));
//     _firstNameLabel             = hpclLabel.steps.firstname;
//     _middleNameLabel            = hpclLabel.steps.middlename;
//     _lastNameLabel              = hpclLabel.steps.lastname;
//     _mobileNoLabel              = hpclLabel.steps.mobile;
//     _customerRegNoLabel         = hpclLabel.steps.reg;
//
//     _guardianNameLabel          = hpclLabel.registration.guardian;
//     _emailIdLabel               = hpclLabel.registration.email;
//     _houseNoLabel               = hpclLabel.registration.house;
//     _localityLabel              = hpclLabel.registration.locality;
//     _townLabel                  = hpclLabel.registration.town;
//     _stateLabel                 = 'State';
//     _districtLabel              = hpclLabel.registration.district;
//     _pinCodeLabel               = hpclLabel.registration.pincode;
//     _areaLabel                  = hpclLabel.registration.area;
//     _propertyCategoryNameLabel  = hpclLabel.registration.propertyCategory;
//     _propertyCategoryClassLabel = hpclLabel.registration.propertyClass;
//     _lmcFeasibilityDateLabel    = hpclLabel.lmc.feasibilityDate;
//     _lmcProposedDateLabel       = hpclLabel.lmc.proposedDate;
//     _additionalLabel            = hpclLabel.lmc.additional;
//     _qtyLabel                   = hpclLabel.lmc.qty;
//     //_installationLabel          = hpclLabel.lmc.installation;
//     //_feasibilityLabel           = hpclLabel.lmc.feasibility;
//     _materialLabel              = hpclLabel.lmc.material;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _getLabelsData();
//     _getFreeMaterialData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     pr = ProgressDialog(context);
//     pr = ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
//
//     double _width = MediaQuery. of(context). size. width/4;
//     return new Container(
//         child : new Wrap(
//           direction: Axis.horizontal,
//           children: [
//             Container(
//               height: 2,
//             ),
//             InkWell(
//               child: Container(
//                 height: 60.0,
//                 color : Colors.black12,
//                 child :  Row(
//                   mainAxisSize: MainAxisSize.max,
//                   children: [
//                     Container(width: _width, child: Center(child: Text(widget.rows.areaName??'',style: AppTextStyle.textTitle,),),),
//                     Container(width: _width, child: Center(child: Text(widget.rows.mobileNumber??'',style: AppTextStyle.textTitle,),),),
//                     Container(width: _width, child: Center(child: Text(widget.rows.firstName??'',style: AppTextStyle.textTitle,),),),
//                     Container(width: _width, child: Center(child: Text(widget.rows.email??'',style: AppTextStyle.textTitle,),),),
//                   ],
//                 ),
//               ),
//               onTap:(){
//                 _showDetailsDialog(context,'LMC Details',widget.rows);
//               },
//             ),
//
//             /*Row(
//               mainAxisSize: MainAxisSize.max,
//               children: [
//                 Container(width: 80.0,  child: Center(child: Text('',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 80.0,  child: Center(child: Text('',style: AppTextStyle.tableTitle,),),),
//                 //Container(width: 200.0, child: Center(child: Text(widget.rows.customerRegistrationNo??'',style: AppTextStyle.tableTitle,textAlign: TextAlign.center,),),),
//                 //Container(width: 180.0, child: Center(child: Text(widget.rows.feasibilityVisitDate??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 180.0, child: Center(child: Text(widget.rows.proposedDate??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 100.0, child: Center(child: Text(widget.rows.areaName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.mobileNumber??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.firstName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.middleName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.lastName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.guardianName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.email??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.propName??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.propClass??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.houseNumber??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.locality??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.town??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.state??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.district??'',style: AppTextStyle.tableTitle,),),),
//                 Container(width: 160.0, child: Center(child: Text(widget.rows.pinCode??'',style: AppTextStyle.tableTitle,),),),
//
//               ],
//             )*/
//           ],
//         )
//     );
//   }
//
//   _showDetailsDialog(BuildContext mContext,String title,Rows rows) async {
//     return showDialog<void>(
//       context: mContext,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: [
//
//                 (rows.isInstall==null )?Container(
//                   child: Padding(
//                     padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                             child: Text('Action',)
//                         ),
//                         Expanded(
//                           child:  Align(
//                             alignment: Alignment.centerRight,
//                             child: rows.dmaRegId==null
//                                 ?InkWell(
//                               child:Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue,
//                                   border: Border.all(
//                                     color: Colors.blue,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(0),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                       size: 20.0,
//                                     ),
//                                     Text('Feasibility',style: TextStyle(color: Colors.white),)
//                                   ],
//                                 ),
//                               ),
//                               onTap: (){
//                                 Navigator.of(context).pop();
//                                 Navigator.push(
//                                     mContext,
//                                     MaterialPageRoute(builder: (context) => FeasibilityScreen(rows: rows,)));
//                                 //_showFeasibilityDialog(context,'Feasibility Details Form',widget.rows);
//                               },
//                             )
//                                 :InkWell(
//                               child:Container(
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue,
//                                   border: Border.all(
//                                     color: Colors.blue,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(0),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(
//                                       Icons.edit,
//                                       color: Colors.white,
//                                       size: 20.0,
//                                     ),
//                                     Text('Installation',style: TextStyle(color: Colors.white),)
//                                   ],
//                                 ),
//                               ),
//                               onTap: (){
//                                 Navigator.of(context).pop();
//                                 Navigator.push(
//                                     mContext,
//                                   MaterialPageRoute(builder: (context) => InstallationScreen(rows: rows,action:'Push')));
//                                 //_showInstallationDialog(context,'Installation Details Form',widget.rows);
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ):Container(),
//
//                 getTextField('$_customerRegNoLabel',rows.crn??'Registration No'),
//                 getTextField('$_lmcFeasibilityDateLabel',getDate(rows.feasibilityVisitDate)??''),
//                 getTextField('$_lmcProposedDateLabel',getDate(rows.proposedDate)??''),
//                 getTextField('$_areaLabel',rows.areaName),
//                 getTextField('$_mobileNoLabel',rows.mobileNumber),
//                 getTextField('$_firstNameLabel',rows.firstName),
//                 getTextField('$_middleNameLabel',rows.middleName),
//                 getTextField('$_lastNameLabel',rows.lastName),
//                 getTextField('$_guardianNameLabel',rows.guardianName),
//                 getTextField('$_emailIdLabel',rows.emailId),
//                 getTextField('$_propertyCategoryNameLabel',rows.propName),
//                 getTextField('$_propertyCategoryClassLabel',rows.propClass),
//                 getTextField('$_houseNoLabel',rows.houseNumber),
//                 getTextField('$_localityLabel',rows.locality),
//                 getTextField('$_townLabel',rows.town),
//                 getTextField('$_stateLabel',rows.state),
//                 getTextField('$_districtLabel',rows.district),
//                 getTextField('$_pinCodeLabel',rows.pinCode),
//
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('OK'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//
//   getTextField(String hintText,
//       String fieldText,{TextInputType keyboardType = TextInputType.text}) {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
//         child: DefaultTextStyle(
//           style: TextStyle(color: Colors.black),
//           child: TextFormField(
//             keyboardType: keyboardType,
//             autofocus: false,
//             enabled: false,
//             initialValue: fieldText,
//             decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText:  hintText ,
//                 hintText: hintText),
//           ),
//         ),
//       ),
//     );
//   }
//
//
//
//   _showFeasibilityDialog(BuildContext mContext,String title,Rows rows) async {
//     bool _checkBoxStatus=false;
//
//     DateTime _proposedDate           = DateTime.now();
//     DateTime _feasibilityVisitDate   = DateTime.now();
//
//     Future<DateTime>  _selectProposedDate(BuildContext context) async {
//       final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(), // Refer step 1
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2050),
//       );
//       if (picked != null) {
//         setState(() {
//           _proposedDate = picked;
//         });
//         return picked;
//       }
//       return DateTime.now();
//     }
//
//     return showDialog<void>(
//       context: mContext,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState){
//                 return Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Wrap(
//                             children: [
//                               Text('$_firstNameLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.firstName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_middleNameLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.middleName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_lastNameLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.lastName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_guardianNameLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.guardianName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_mobileNoLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.mobileNumber,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_emailIdLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.email,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_propertyCategoryNameLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.propName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_propertyCategoryClassLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.propClass,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_houseNoLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.houseNumber,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_localityLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.locality,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_areaLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.areaName,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_districtLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text(rows.district,style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_lmcProposedDateLabel',style: AppTextStyle.headline,),
//                               InkWell(
//                                 child: Container(
//                                   height: 45,
//                                   decoration: BoxDecoration(
//                                     color: const Color(0xffFFFFFF),
//                                     border: Border.all(
//                                       color: Colors.grey,
//                                       width: 1,
//                                     ),
//                                     borderRadius: BorderRadius.circular(5),
//                                   ),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: Text("${_proposedDate.toLocal()}".split(' ')[0],style: AppTextStyle.textContent,),
//                                     ),
//                                   ),
//                                 ),
//                                 onTap: (){
//                                   _selectProposedDate(context).then((value) => (
//                                       setState(() {
//                                         print("${value.toLocal()}".split(' ')[0]);
//                                       })
//                                   ));
//
//                                 },
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Wrap(
//                             children: [
//                               Text('$_lmcFeasibilityDateLabel',style: AppTextStyle.headline,),
//                               Container(
//                                 height: 45,
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xffFFFFFF),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                     width: 1,
//                                   ),
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: EdgeInsets.only(left: 10),
//                                     child: Text("${_feasibilityVisitDate.toLocal()}".split(' ')[0],style: AppTextStyle.textContent,),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Checkbox(
//                                 checkColor: Colors.greenAccent,
//                                 activeColor: Colors.green,
//                                 value: _checkBoxStatus,
//                                 onChanged: (bool value) {
//                                   print(value);
//                                   _checkBoxStatus = value;
//                                   setState(() {
//                                   });
//                                 },
//                               ),
//                               Text('$_additionalLabel',style: AppTextStyle.headline,),
//                             ],
//                           ),
//                           SizedBox(height: 15,),
//                         ],
//                       ),
//                       _checkBoxStatus
//                           ?Container(
//                         child:
//                         Column(
//                           children: [
//                             Row(children: [
//                               Expanded(
//                               flex: 6,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text('$_materialLabel',style: AppTextStyle.headline,),
//                                   Container(
//                                     padding: EdgeInsets.only(left: 10),
//                                     height: 45,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xffFFFFFF),
//                                       border: Border.all(
//                                         color: Colors.grey,
//                                         width: 1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child: Expanded(
//                                       child: Align(
//                                         alignment: Alignment.centerLeft,
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<MaterialData>(
//                                             value: _materialName,
//                                             items:  _materialDropdownItems,
//                                             onChanged: (value){
//                                               setState(() {
//                                                 _materialName = value;
//                                                 _materialId   = value.id;
//                                               });
//                                             },
//                                             isExpanded: true,
//                                             isDense: true,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )),
//                               Expanded(
//                               flex: 2,
//                               child: Column(
//                                 children: [
//                                   Text('$_qtyLabel',style: AppTextStyle.headline,),
//                                   Container(
//                                     height: 45,
//                                     decoration: BoxDecoration(
//                                       color: const Color(0xffFFFFFF),
//                                       border: Border.all(
//                                         color: Colors.grey,
//                                         width: 1,
//                                       ),
//                                       borderRadius: BorderRadius.circular(5),
//                                     ),
//                                     child:Padding(
//                                       padding: EdgeInsets.only(left: 10),
//                                       child: TextFormField(
//                                         controller: qtyController,
//                                         keyboardType: TextInputType.number,
//                                         onSaved: (String value) {
//                                           _numberValue = value;
//                                         },
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               )),
//                               Expanded(
//                             flex: 2,
//                             child: InkWell(
//                               child: Align(
//                                 alignment: Alignment.center,
//                                 child: Container(
//                                   child: Icon(
//                                     Icons.add,
//                                     color: Colors.green,
//                                     size: 30.0,
//                                   ),
//                                 ),
//                               ),
//                               onTap: (){
//                                 _numberValue = qtyController.text;
//                                 if(_numberValue!='0' && _numberValue!=''){
//                                   MaterialItem map = MaterialItem(id: _materialId,name:_materialName.materialName,value: _numberValue );
//                                   _materialList.add(map);
//                                   setState(() {
//                                   });
//                                   qtyController.clear();
//                                   _toast('Added');
//                                 }
//                                 else{
//                                   _toast('Enter valid quantity number$_numberValue');
//                                 }
//                               },
//                             ),
//                           ),],),
//                             SizedBox(height: 15,),
//                             Container(
//                               height: 45,
//                               color: Colors.grey,
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     flex: 1,
//                                     child: Text('S.No.',style: AppTextStyle.headline,textAlign: TextAlign.center,),),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Text('Qty',style: AppTextStyle.headline,textAlign: TextAlign.center,),),
//                                   Expanded(
//                                     flex: 1,
//                                     child: Text('Action',style: AppTextStyle.headline,textAlign: TextAlign.center,),
//                                   ),
//                                 ],),
//                             ),
//                             Column(
//                               children: _materialList.map((item) {
//                                 return ListTile(
//                                   title: Row(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(item.name),
//                                       Text(item.value),
//                                       InkWell(
//                                         child: Align(
//                                           alignment: Alignment.center,
//                                           child: Icon(
//                                             Icons.cancel,
//                                             color: Colors.red,
//                                             size: 25.0,
//                                           ),
//                                         ),
//                                         onTap: (){
//                                           _materialList.remove(item);
//                                           setState(() {
//                                           });
//                                           _toast('Remove');
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               }).toList(),
//                             ),
//                           ],
//                       ),):Container(),
//                     ]
//                 );
//               },
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('OK'),
//               onPressed: () {
//                 String _strProposedDate = "${_proposedDate.toLocal()}".split(' ')[0];
//                 String _strVisitDate    = "${_feasibilityVisitDate.toLocal()}".split(' ')[0];
//
//                 _postFeasibilityData(rows,_strProposedDate,_strVisitDate,_materialList);
//                 //Navigator.of(context).pop();
//               },
//             ),
//             FlatButton(
//               child: Text('Dismiss'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   _showInstallationDialog(BuildContext mContext,String title,Rows rows) async {
//
//
//     TextEditingController workStartDateController   = TextEditingController();
//
//     TextEditingController meterNoController         = TextEditingController();
//     TextEditingController pipeController            = TextEditingController();
//     TextEditingController fittingController         = TextEditingController();
//     TextEditingController initialReadingController  = TextEditingController();
//     TextEditingController meterReadingDateController= TextEditingController();
//     TextEditingController tfNoController            = TextEditingController();
//
//     TextEditingController tfLongitudeController     = TextEditingController();
//     TextEditingController tfLatitudeController      = TextEditingController();
//
//     TextEditingController houseLongitudeController  = TextEditingController();
//     TextEditingController houseLatitudeController   = TextEditingController();
//
//     TextEditingController workCompleteDateController= TextEditingController();
//     TextEditingController workAcknowledgmentDateController= TextEditingController();
//     PhotoController workCompleteController          = PhotoController();
//     PhotoController acknowledgmentImgController     = PhotoController();
//     PhotoController meterImgController              = PhotoController();
//
//     Position positional;
//
//     List<DropdownMenuItem<OptionItem>> reasonArrItems = ([
//       DropdownMenuItem(
//         value: OptionItem(id:'0',title: 'Select Reason Delay',),
//         child: Text('Select Delay Reason'),
//       ),
//       DropdownMenuItem(
//         value: OptionItem(id:'1',title: 'Customer Hold',),
//         child: Text('Customer Hold'),
//       ),
//       DropdownMenuItem(
//         value: OptionItem(id:'2',title: 'Unavailable',),
//         child: Text('Unavailable'),
//       ),
//     ]);
//
//     OptionItem _reasonIfDelay = reasonArrItems.first.value;
//     Future<DateTime>  _selectDate(BuildContext context) async {
//       final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(), // Refer step 1
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2050),
//       );
//       if (picked != null) {
//         return picked;
//       }
//       return DateTime.now();
//     }
//
//     getTextFormField(TextEditingController controller,
//         {Function(String) onChanged, String hintText, String fieldText,int maxLimit,
//           bool focusable = false, TextInputType keyboardType}) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//         child: DefaultTextStyle(
//           style: TextStyle(color: Colors.black),
//           child: TextFormField(
//             controller: controller,
//             //initialValue: fieldText,
//             keyboardType: keyboardType,
//             maxLength: maxLimit??20,
//             autofocus: focusable,
//             decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: hintText,hintText: fieldText??""),
//             onChanged: onChanged,
//           ),
//         ),
//       );
//     }
//
//
//     getLatLongTextField(TextEditingController controller,
//         {Function(String) onChanged,
//           String hintText,
//           String fieldText,
//           bool focusable = false,
//           TextInputType keyboardType = TextInputType.text}) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//         child: DefaultTextStyle(
//           style: Theme.of(context).textTheme.subhead,
//           child: TextFormField(
//             keyboardType: keyboardType,
//             controller: controller,
//             enabled: focusable,
//             decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText: fieldText ?? hintText ?? "",
//                 hintText: hintText ?? fieldText ?? ""),
//             onChanged: (value) {
//               if (onChanged != null) onChanged(value);
//             },
//           ),
//         ),
//       );
//     }
//
//
//
//     getTextField(String hintText,
//         String fieldText,{
//           TextEditingController controller,
//           Function onChanged,
//           TextInputType keyboardType = TextInputType.text}) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//         child: DefaultTextStyle(
//           style: TextStyle(color: Colors.black),
//           child: TextFormField(
//             controller: controller,
//             onTap: onChanged,
//             keyboardType: keyboardType,
//             autofocus: false,
//             enabled: false,
//             initialValue: fieldText,
//             decoration: new InputDecoration(
//                 border: OutlineInputBorder(),
//                 labelText:  hintText ,
//                 hintText: hintText),
//           ),
//         ),
//       );
//     }
//
//     getDropDown(dropListModel,OptionItem _value,
//         {title, Function(OptionItem optionItem) onChanged}) {
//       return Padding(
//         padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
//         child:
//         DropdownButtonFormField<OptionItem>(
//           decoration: InputDecoration(labelText: title,border: OutlineInputBorder(),),
//           value: _value,
//           items: dropListModel /*List.generate(
//             dropListModel.length,
//                 (i) => DropdownMenuItem(
//               value: dropListModel[i],
//               child: Text(dropListModel[i].title),
//             ),
//           )*/,
//           onChanged: onChanged,
//         ),
//       );
//     }
//
//     _getCurrentLocation(String which) {
//       final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//       geolocator
//           .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//           .then((Position position) {
//         setState(() {
//           positional = position;
//           if(which=='TF'){
//             tfLongitudeController.text = '${position.longitude}';
//             tfLatitudeController.text = '${position.latitude}';
//           }else{
//             houseLongitudeController.text = '${position.longitude}';
//             houseLatitudeController.text = '${position.latitude}';
//           }
//           print("lat: ${position.latitude} lag: ${position.longitude}");
//           // _currentPosition = position;
//         });
//       }).catchError((e) {
//         print(e);
//       });
//     }
//
//     _uploadImage() async {
//
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       var token =  prefs.getString(GlobalConstants.token);
//       var schema = prefs.getString(GlobalConstants.schema);
//       //var schema = prefs.getString(GlobalConstants.schema);
//
//       Map<String, String> headers = {
//         "authorization": token,
//         'content-type': 'multipart/form-data',
//       };
//
//       if(workStartDateController.text==''){
//         _toast('Select Work Start Date');
//         return;
//       }else if(_reasonIfDelay.title=='Select Delay Reason'||_reasonIfDelay.title==''){
//         _toast('Select Delay Reason');
//         return;
//       }else if(meterNoController.text==''){
//         _toast('Enter Meter No.');
//         return;
//       }else if(pipeController.text==''){
//         _toast('Enter Pipe No.');
//         return;
//       }else if(fittingController.text==''){
//         _toast('Enter Fitting No.');
//         return;
//       }else if(initialReadingController.text==''){
//         _toast('Enter Initial Reading');
//         return;
//       }else if(meterReadingDateController.text==''){
//         _toast('Select Meter Reading Date');
//         return;
//       }else if(meterImgController.imagePath==null||meterImgController.imagePath.path==''){
//         _toast('Choose Meter Photo');
//         return;
//       }else if(tfNoController.text==''){
//         _toast('Enter TF No.');
//         return;
//       }else if(tfLatitudeController.text==''){
//         _toast('Enter TF Location Coordinate');
//         return;
//       }else if(tfLongitudeController.text==''){
//         _toast('Enter TF Location Coordinate');
//         return;
//       }else if(houseLatitudeController.text==''){
//         _toast('Enter House Location Coordinate');
//         return;
//       }else if(houseLongitudeController.text==''){
//         _toast('Enter House Location Coordinate');
//         return;
//       }else if(workCompleteDateController.text==''){
//         _toast('Select Work Complete Date');
//         return;
//       }else if(workCompleteController.imagePath==null||workCompleteController.imagePath.path==''){
//         _toast('Choose Work Complete Photo');
//         return;
//       }else if(workAcknowledgmentDateController.text==''){
//         _toast('Select Acknowledgment Date');
//         return;
//       }else if(acknowledgmentImgController.imagePath==null||acknowledgmentImgController.imagePath.path==''){
//         _toast('Choose Acknowledgment Photo');
//         return;
//       }
//
//
//       Map<String, String> requestBody = <String,String>{
//         "dma_id":rows.dmaId,
//         "material_id":'',
//         "actual_work_start":workStartDateController.text,
//         "meter_number":meterNoController.text,
//         "pipe":pipeController.text,
//         "delay_reason":_reasonIfDelay.title,
//         "fittings":fittingController.text,
//         "meter_reading_date":meterReadingDateController.text,
//         "meter_reading":initialReadingController.text,
//         "tf_number": (tfNoController.text),
//         "latitude_tf":tfLatitudeController.text,
//         "longitude_tf":tfLongitudeController.text,
//         "latitude_hg":houseLatitudeController.text,
//         "longitude_hg":houseLongitudeController.text,
//         "work_completed_date":workCompleteDateController.text,
//         "cust_ack_date":workAcknowledgmentDateController.text,
//         "proposed_date":getCurrentDate(),
//         "schema":schema,
//       };
//
//       print(requestBody.toString());
//
//       String url = GlobalConstants.saveLmcInstallation;
//       try {
//         var request = http.MultipartRequest('POST', Uri.parse(url));
//         request.headers.addAll(headers);
//         request.fields.addAll(requestBody);
//
//         //create multipart using filepath, string or bytes
//         var pic1 = await http.MultipartFile.fromPath("meter_photo", meterImgController.imagePath.path);
//         var pic2 = await http.MultipartFile.fromPath("work_completed_image", workCompleteController.imagePath.path);
//         var pic3 = await http.MultipartFile.fromPath("cust_ack_image", acknowledgmentImgController.imagePath.path);
//         //add multipart to request
//         request.files.add(pic1);
//         request.files.add(pic2);
//         request.files.add(pic3);
//
//         var response = await request.send();
//         //Get the response from the server
//         var responseData = await response.stream.toBytes();
//         var responseString = String.fromCharCodes(responseData);
//
//         print(responseString);
//         pr.hide();
//         Success _res = new Success.fromJson(json.decode(responseString));
//         if(_res.success == 200) {
//           _showMyDialog(context, _res.message[0].code);
//           //clear();
//         }else{
//           // ErrorResponse errorResponse = ErrorResponse.fromJson(json.decode(responseString));
//           // List<String> _resList=errorResponse.errors;
//           // List<Widget> widgets = _resList.map((e) => Text(e)).toList();
//           //_showDialog(context, 'Error',widgets);
//           _showMyDialog(context, responseString);
//         }
//       }catch(Exception){
//       }
//     }
//
//
//
//     String _firstNameLabel='First Name',_middleNameLabel='Middle Name',_surNameLabel='Surname',_guardianNameLabel='Guardian Name';
//     String _mobileLabel='Mobile',_emailLabel='Email',_proposedDateLabel='Proposed Start Date *',_actualWorkStartLabel='Actual Work Start *';
//     String _reasonLabel='Reason if Delay',_meterNoLabel='Meter Number *',_pipeLabel='Pipe',_fittingsLabel='Fittings';
//     String _initialReadingLabel='Meter Initial Reading *',_readingDateLabel='Meter Reading Date *',_meterPhotoLabel='Meter Photo *',_tfNoLabel='TF Number';
//     String _tfLatitudeLabel='Latitude (TF)',_tfLongitudeLabel='Longitude (TF)',_houseLatLabel='Latitude (House Gate)',_houseLongLabel='Longitude (House Gate)';
//     String _workCompleteDateLabel='Work Completed Date *',_workCompleteImgLabel='Work Completed Image *',_acknowledgmentDateLabel='Customer Acknowledgment Date *',_acknowledgmentImgLabel='Customer Acknowledgment Image *';
//
//     String _takePhotoLabel ='Take Photo';
//     String _btnTfLocationLabel ='Get TF Location';
//     String _btnHouseLocationLabel ='Get House Location';
//
//     return showDialog<void>(
//       context: mContext,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: SingleChildScrollView(
//             child: StatefulBuilder(
//               builder: (BuildContext context, StateSetter setState){
//                 return Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           SizedBox(height: 10,),
//                           getTextField(_firstNameLabel,'${rows.firstName}'),
//                           SizedBox(height: 15,),
//                           getTextField(_middleNameLabel,'${rows.middleName}'),
//                           SizedBox(height: 15,),
//                           getTextField(_surNameLabel,'${rows.lastName}'),
//                           SizedBox(height: 15,),
//                           getTextField(_guardianNameLabel,'${rows.guardianName}'),
//                           SizedBox(height: 15,),
//                           getTextField(_mobileLabel,'${rows.mobileNumber}'),
//                           SizedBox(height: 15,),
//                           getTextField(_emailLabel,'${rows.emailId}'),
//                           SizedBox(height: 15,),
//                           getTextField(_proposedDateLabel,'${"${DateTime.now().toLocal()}".split(' ')[0]}'),
//                           SizedBox(height: 15,),
//
//                           /*Actual Work Start **/
//                           DefaultTextStyle(
//                             style: TextStyle(color: Colors.black),
//                             child: InkWell(
//                               child: TextFormField(
//                                 controller: workStartDateController,
//                                 autofocus: false,
//                                 enabled: false,
//                                 //initialValue: getCurrentDate(),
//                                 decoration: new InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText:  _actualWorkStartLabel ,
//                                     hintText: _actualWorkStartLabel),
//                               ),
//                               onTap: (){
//                                 _selectDate(context).then((value) =>
//                                     setState(() {
//                                       workStartDateController.text = ("${value.toLocal()}".split(' ')[0]);
//                                     })
//                                 );
//                               },
//                             ),
//                           ),
//
//                           SizedBox(height: 15,),
//                           getDropDown(reasonArrItems, _reasonIfDelay,title: _reasonLabel,onChanged:(OptionItem value) {
//                             setState(() {
//                               _reasonIfDelay = value;
//                             });
//                           },),
//                           SizedBox(height: 15,),
//                           getTextFormField(meterNoController,hintText: _meterNoLabel,fieldText: '0',keyboardType: TextInputType.numberWithOptions()),
//                           getTextFormField(pipeController,hintText: _pipeLabel,fieldText: '0',keyboardType: TextInputType.number),
//                           getTextFormField(fittingController,hintText: _fittingsLabel,fieldText: '0',keyboardType: TextInputType.number),
//                           getTextFormField(initialReadingController,hintText: _initialReadingLabel,fieldText: '0',keyboardType: TextInputType.number),
//
//                           //Meter Reading Date *
//                           DefaultTextStyle(
//                             style: TextStyle(color: Colors.black),
//                             child: InkWell(
//                               child: TextFormField(
//                                 controller: meterReadingDateController,
//                                 autofocus: false,
//                                 enabled: false,
//                                 decoration: new InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText:  _readingDateLabel ,
//                                     hintText: _readingDateLabel),
//                               ),
//                               onTap: (){
//                                 _selectDate(context).then((value) =>
//                                     setState(() {
//                                       meterReadingDateController.text=("${value.toLocal()}".split(' ')[0]);
//                                     })
//                                 );
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 15,),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 15,),
//                               Text(_meterPhotoLabel,style: AppTextStyle.headline,),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                                 child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       RaisedButton(
//                                           color: Theme.of(context).primaryColor,
//                                           child: Text(_takePhotoLabel,style: TextStyle(color: Colors.white),),
//                                           onPressed: () async {
//                                             getImage(meterImgController).then((value) =>
//                                                 setState(() {}));
//                                           }
//                                       ),
//                                     ]),
//                               ),
//                               meterImgController.imagePath!=null?Container(child:Row(children: [Image.file(
//                                 meterImgController.imagePath,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),],))
//                                   :Container(child:Row(children: [Image.asset(
//                                 'assets/icons/place_holder.png',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               )])),
//
//                             ],
//                           ),
//                           SizedBox(height: 10,),
//                           getTextFormField(tfNoController,hintText: _tfNoLabel,fieldText: '0',keyboardType: TextInputType.number,maxLimit: 10),
//                           getLatLongTextField(
//                               tfLatitudeController
//                                 ..text =
//                                 positional != null ? positional.longitude.toString() : "",
//                               hintText: _tfLatitudeLabel,),
//                           getLatLongTextField(tfLongitudeController..text = positional != null ? positional.latitude.toString() : "",
//                               hintText: _tfLongitudeLabel,),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   RaisedButton(
//                                       color: Theme.of(context).primaryColor,
//                                       child: Text(_btnTfLocationLabel,style: TextStyle(color: Colors.white),),
//                                       onPressed: () async {
//                                         _getCurrentLocation('TF');
//                                       }
//                                       ),
//                                 ]),
//                           ),
//
//                           /*HouseLatilong*/
//                           getLatLongTextField(
//                             houseLatitudeController
//                                 ..text =
//                                 positional != null ? positional.longitude.toString() : "",
//                               hintText: _houseLatLabel,),
//                           getLatLongTextField(houseLongitudeController..text = positional != null ? positional.latitude.toString() : "",
//                               hintText: _houseLongLabel,),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                             child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   RaisedButton(
//                                       color: Theme.of(context).primaryColor,
//                                       child: Text(_btnHouseLocationLabel,style: TextStyle(color: Colors.white),),
//                                       onPressed: () async {
//                                         _getCurrentLocation('');
//                                       }
//                                       ),
//                                 ]),
//                           ),
//
//                           //Work Complete Date *
//                           DefaultTextStyle(
//                             style: TextStyle(color: Colors.black),
//                             child: InkWell(
//                               child: TextFormField(
//                                 controller: workCompleteDateController,
//                                 autofocus: false,
//                                 enabled: false,
//                                 decoration: new InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText:  _workCompleteDateLabel ,
//                                     hintText: _workCompleteDateLabel),
//                               ),
//                               onTap: (){
//                                 _selectDate(context).then((value) =>
//                                     setState(() {
//                                       workCompleteDateController.text=("${value.toLocal()}".split(' ')[0]);
//                                     })
//                                 );
//                               },
//                             ),
//                           ),
//
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 15,),
//                               Text(_workCompleteImgLabel,style: AppTextStyle.headline,),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                                 child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       RaisedButton(
//                                           color: Theme.of(context).primaryColor,
//                                           child: Text(_takePhotoLabel,style: TextStyle(color: Colors.white),),
//                                           onPressed: () async {
//                                             getImage(workCompleteController).then((value) =>
//                                                 setState(() {}));
//                                           }
//                                       ),
//                                     ]),
//                               ),
//                               workCompleteController.imagePath!=null?Container(child:Row(children: [Image.file(
//                                 workCompleteController.imagePath,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),],))
//                                   :Container(child:Row(children: [Image.asset(
//                                 'assets/icons/place_holder.png',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               )])),
//
//                             ],
//                           ),
//
//                           SizedBox(height: 15,),
//                           //Customer Acknowledgment Date *
//                           DefaultTextStyle(
//                             style: TextStyle(color: Colors.black),
//                             child: InkWell(
//                               child: TextFormField(
//                                 controller: workAcknowledgmentDateController,
//                                 autofocus: false,
//                                 enabled: false,
//                                 decoration: new InputDecoration(
//                                     border: OutlineInputBorder(),
//                                     labelText:  _acknowledgmentDateLabel ,
//                                     hintText: _acknowledgmentDateLabel),
//                               ),
//                               onTap: (){
//                                 _selectDate(context).then((value) =>
//                                     setState(() {
//                                       workAcknowledgmentDateController.text=("${value.toLocal()}".split(' ')[0]);
//                                     })
//                                 );
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 15,),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 15,),
//                               Text(_acknowledgmentImgLabel,style: AppTextStyle.headline,),
//                               Padding(
//                                 padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
//                                 child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       RaisedButton(
//                                           color: Theme.of(context).primaryColor,
//                                           child: Text(_takePhotoLabel,style: TextStyle(color: Colors.white),),
//                                           onPressed: () async {
//                                             getImage(acknowledgmentImgController).then((value) =>
//                                                 setState(() {}));
//                                           }
//                                       ),
//                                     ]),
//                               ),
//                               acknowledgmentImgController.imagePath!=null?Container(child:Row(children: [Image.file(
//                                 acknowledgmentImgController.imagePath,
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               ),],))
//                                   :Container(child:Row(children: [Image.asset(
//                                 'assets/icons/place_holder.png',
//                                 width: 100,
//                                 height: 100,
//                                 fit: BoxFit.cover,
//                               )])),
//
//                             ],
//                           ),
//
//                         ],
//                       ),
//                     ]
//                 );
//               },
//             ),
//           ),
//           actions: <Widget>[
//             FlatButton(
//               child: Text('Submit'),
//               onPressed: () {
//                 _uploadImage();
//                 //Navigator.of(context).pop();
//               },
//             ),
//             FlatButton(
//               child: Text('Dismiss'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   Future<void> getImage(PhotoController photoController)async{
//     final picker = ImagePicker();
//     File _image;
//     final pickedFile =
//     await picker.getImage(source:ImageSource.gallery,maxHeight:100,maxWidth:100,imageQuality: 60);
//     setState(() {
//       if (pickedFile != null) {
//         _image=File(pickedFile.path);
//         if (photoController != null)
//           photoController.imagePath = File(pickedFile.path);
//         //return _image;
//       } else {
//         print('No image selected.');
//       }
//       //return _image;
//     });
//   }
//
//   Future<void> _getFreeMaterialData() async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var schema =  prefs.getString(GlobalConstants.schema);
//     var res = await http.get( (GlobalConstants.getFreeMaterialApi+schema));
//     if(res.statusCode == 200) {
//       FreeMaterial dataList = FreeMaterial.fromJson(json.decode(res.body));
//       List<DropdownMenuItem<MaterialData>> menuItems = [];
//
//       menuItems = List.generate(
//         dataList.data.length,
//             (i) => DropdownMenuItem(
//           value: dataList.data[i],
//           child: Text("${dataList.data[i].materialName}"),
//         ),
//       );
//       if (!mounted) return;
//       setState(() {
//         _materialDropdownItems = menuItems;
//         _materialName = _materialDropdownItems.first.value;
//         _materialId   = _materialName.id;
//       });
//     }
//   }
//   Future<void> _postFeasibilityData(Rows rows, String strProposedDate, String strVisitDate, List<MaterialItem> materialList) async {
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var schema  =  prefs.getString(GlobalConstants.schema);
//     var token   =  prefs.getString(GlobalConstants.token);
//     var lmcId   =  rows.lmcId;
//     var dmaId   =  rows.dmaId;
//     var bom     =  '1';
//     var _arrId  = _materialList.asMap().values.map((e) => e.id).toList();
//     var _arrQty = _materialList.asMap().values.map((e) => e.value).toList();
//
//     var jsonVAr = {
//       'lmcId': lmcId,
//       'dmaId': dmaId,
//       'proposed_date': strProposedDate,
//       'feasibility_visit_date': strVisitDate,
//       'schema': schema,
//       'bom': bom,
//       'material_id[]': _arrId.toString(),
//       'qty[]': _arrQty.toString(),
//     };
//
//     print(jsonVAr.toString());
//     //return;
//     await pr.show();
//
//     var res = await http.post(
//         (GlobalConstants.postFeasibilityDataApi),
//         body: jsonVAr,
//         headers: {'authorization':'$token'}
//         //body: jsonEncode(<String, String>jsonVAr)
//     );
//     print(res.body);
//     Success _res = new Success.fromJson(json.decode(res.body));
//     if(_res.success == 200) {
//       pr.hide();
//       _showMyDialog(context,_res.message[0].code);
//       print(res.body);
//     }else{
//       pr.hide();
//       print(res.body);
//     }
//   }
//
//   String getDate(String savedDateString){
//     if(savedDateString!=null && savedDateString !='') {
//       String tempDate = new DateFormat("yyyy-MM-dd").format(DateTime.parse(savedDateString));
//       return tempDate;
//     }
//     return '';
//   }
//   String getCurrentDate(){
//     String date = DateFormat("yyyy-MM-dd").format(DateTime.now());
//     return date;
//   }
//   _toast(String _msg){
//     Fluttertoast.showToast(
//         msg: _msg,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.CENTER,
//         timeInSecForIosWeb: 1,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//         fontSize: 16.0
//     );
//   }
//
// }
//
// class PhotoController {
//   File imagePath;
// }
//
// getDropDown(dropListModel,OptionItem _value,
//     {title, Function(OptionItem optionItem) onChanged}) {
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 10.0),
//     child:
//     DropdownButtonFormField<OptionItem>(
//       decoration: InputDecoration(labelText: title,border: OutlineInputBorder(),),
//       value: _value,
//       items:  List.generate(
//         dropListModel.length,
//             (i) => DropdownMenuItem(
//           value: dropListModel[i],
//           child: Text(dropListModel[i].title),
//         ),
//       ),
//       onChanged: onChanged,
//     ),
//   );
// }
//
// class OptionItem {
//   final String id;
//   final String title;
//
//
//   OptionItem({@required this.id, @required this.title});
//
// }
// class MaterialItem {
//   final String id;
//   final String name;
//   final String value;
//
//
//   MaterialItem({@required this.id, @required this.name,@required this.value});
//
// }
//
// Future<void> _showMyDialog(BuildContext mContext,String _msg) async {
//   return showDialog<void>(
//     context: mContext,
//     barrierDismissible: false, // user must tap button!
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: Text('Alert'),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Text(_msg),
//               //Text('Would you like to approve of this message?'),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//               Navigator.of(mContext).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }