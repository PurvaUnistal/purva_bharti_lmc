// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:lmc/model/AllBillError.dart';
// import 'package:lmc/model/GenerateBill.dart';
// import 'package:lmc/utils/global_constant.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class GenerateBill extends StatefulWidget {
//   static String tag = 'login-page';
//   @override
//   State<StatefulWidget> createState() {
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
//     return new _GenerateBill();
//   }
// }
// class _GenerateBill extends State<GenerateBill> {
//   var democheck = false;
//   var democheckNo = false;
//   Future <List<GenerateBill>> futureData;
//   TextEditingController mobileNumberControler = new TextEditingController(text: '');
//   Generatebill _allBillsHistoryResponse;
//   SharedPreferences prefs;
//   var count = 0;
//   var EXITCOUNT = 0;
//   var FRESSCOUNT = 0;
//   int totalcount = 0;
//   List<String> mylist = ["ALL"];
//   List<Data> list = [];
//   // ignore: missing_return
//   Future<List<GenerateBill>> getListData() async {
//
//     SharedPreferences pref;
//     pref = await SharedPreferences.getInstance();
//     var id = prefs.getString(GlobalConstants.id);
//     var token = prefs.getString(GlobalConstants.token);
//     var schema = prefs.getString(GlobalConstants.schema);
//     var url = GlobalConstants.getMeters+schema+'&meterSerial=dia&user_id=$id';
//     var response = await http.get(Uri.parse(url),headers: {"authorization": token,});
//     print("getMeters-->" + response.body);
//     if (response.statusCode == 200) {
//       final json = jsonDecode(response.body);
//       _allBillsHistoryResponse = Generatebill.fromJson(json);
//       _allBillsHistoryResponse =
//       new Generatebill.fromJson(jsonDecode(response.body));
//       list = _allBillsHistoryResponse.data;
//       setState(() {
//         _allBillsHistoryResponse = _allBillsHistoryResponse;
//         list = list;
//         print("list$list");
//         print("_allBillsHistoryResponse$list");
//         if (list.isEmpty) {}
//         else{}
//       });
//     }
//     else if (response.statusCode == 403) {
//       showDialog(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("Confirm Exit"),
//               content: Text("Please Login Again"),
//               actions: <Widget>[
//                 TextButton(
//                   child: Text("OK"),
//                   onPressed: () {
//                   /*  Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()));*/
//                   },
//                 ),
//                 /*  FlatButton(
//                       child: Text("NO"),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     )*/
//               ],
//             );
//           }
//       );
//     }
//     else if (response.statusCode == 400) {
//      // AllBillError allBillsHistoryResponse=AllBillError.fromJson(jsonDecode(response.body));
//       //EasyLoading.showInfo("${allBillsHistoryResponse.data}");
//
//     }
//       else if (response.statusCode == 404) {
//       AllBillError allBillsHistoryResponse=AllBillError.fromJson(jsonDecode(response.body));
//       print("allBillsHistoryResponse.data${allBillsHistoryResponse.data}");
//      // EasyLoading.showInfo("${allBillsHistoryResponse.data}");
//
//
//     }
//   }
//
//
//   @override
//   void initState() {
//     //mContext = context;
//     //  pr = new ProgressDialog(mContext);
//
//     //getData();
//     getListData();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//           actionsIconTheme:
//           IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
//           actions: <Widget>[
//           ],
//           title: new Text("Pending Request",),
//           leading: new IconButton(
//               icon: new Icon(Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//
//               }),
//           backgroundColor: Colors.lightBlueAccent),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           list == null ? Container() : CertificationDetails(context),
//         ],
//       ),
//     );
//   }
//     // ignore: non_constant_identifier_names
//     CertificationDetails(BuildContext context) {
//     return Flexible(
//       child: ListView(
//         shrinkWrap: true,
//         physics: const AlwaysScrollableScrollPhysics(),
//         scrollDirection: Axis.vertical,
//         children: [
//           SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//               child: list.isEmpty
//                   ? Center(child: Text(
//                 '', style: TextStyle(fontSize: 18, color: Colors.white),))
//                   : DataTable(
//                 /* sortAscending: sort,
//               sortColumnIndex: 0,*/
//                 headingRowColor:
//                 MaterialStateColor.resolveWith((states) => Colors.black),
//                 dataRowHeight: 50,
//                 dividerThickness: 5,
//                 /*
// Bill Number	CRN	BP Number	Bill Generated Date	Old Reading	Current Reading	Bill Amount	Reject Reason	Status*/
//                 columns: [
//                   DataColumn(
//                     label: Text(
//                       "User Name",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Bill Number",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "CRN",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "BP Number",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "BILL GENERATED DATE",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Old Reading",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Current Reading",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Bill Amount",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//                   ),
//                   DataColumn(
//                     label: Text(
//                       "Reject Reason",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),
//                   /* DataColumn(
//                     label: Text(
//                       "METER SERIAL NUMBER",
//                       style: TextStyle(
//                         fontStyle: FontStyle.italic,
//                         color: Colors.white,
//                       ),
//                     ),
//                     numeric: false,
//
//                   ),*/
//                   DataColumn(
//                     label: Padding(
//                       padding: const EdgeInsets.only(left: 22),
//                       child: Text(
//                         "STATUS",
//                         style: TextStyle(
//                           fontStyle: FontStyle.italic,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     numeric: false,
//                   ),
//                 ],
//                 rows: list
//                     .map(
//                       (user) =>
//                       DataRow(
//                         /* selected: selectedEmployees.contains(user),
//                     onSelectChanged: (b) {
//                       print("Onselect");
//                       onSelectedRow(b, user);
//                     },*/
//                           cells: [
//                             DataCell(
//                               Text(user.firstName.toUpperCase()+" "+
//                                   user.firstName.toUpperCase() == null
//                                   ? '-'
//                                   : user.firstName.toUpperCase()+" "+
//                                   user.firstName.toUpperCase() == null
//                                   ? '-'
//                                   : user.firstName.toUpperCase()+" "+
//                                   user.firstName.toUpperCase()),
//                             ),
//                             DataCell(
//                               Text(user.billNo == null ? '-' : user
//                                   .billNo == null ? '-' : user.billNo),
//                             ),
//                             DataCell(
//                               Text(user.crn == null ? '-' : user
//                                   .crn == null ? '-' : user.crn),
//                             ),
//                               DataCell(
//                               Text(user.bpNumber == null ? '-' : user.bpNumber ==
//                                   null ? '-' : user.bpNumber),
//                             ),
//
//                             DataCell(
//                               Text(user.billGeneratedDate == null ? '-' : user
//                                   .billGeneratedDate == null ? '-' : user
//                                   .billGeneratedDate),
//                             ),
//                             DataCell(
//                               Text(user.oldReading == null ? '-' : user
//                                   .oldReading == null ? '-' : user
//                                   .oldReading),
//                             ),
//                             DataCell(
//                               Text(user.currentBillReading == null ? '-' : user.currentBillReading ==
//                                   null ? '-' : user.currentBillReading),
//                             ),
//                             DataCell(
//                               Text(user.amount == null ? '-' : user.amount == null
//                                   ? '-'
//                                   : user.amount +" INR"),
//                             ),
//                             DataCell(
//                               Text(user.rejectReason == null ? '-' : user.rejectReason == null
//                                   ? '-'
//                                   : user.rejectReason),
//                             ),
//
//                             DataCell(
//                               Center(
//                                 child: Card(
//                                   elevation: 5,
//                                   color: Colors.lightBlueAccent,
//                                   child: Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 15, vertical: 10),
//                                     child: Text('Pending',
//                                         style: TextStyle(
//                                             color: Colors.white,
//                                             fontFamily: 'Montserrat',
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ),
//                               ),
//
//                             ),
//                           ]),
//                 )
//                     .toList(),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
