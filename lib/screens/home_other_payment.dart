import 'dart:developer';
import '../ExportFile/export_file.dart';


class OtherPaymentCollectionPage extends StatefulWidget {
  const OtherPaymentCollectionPage({Key key}) : super(key: key);

  @override
  State<OtherPaymentCollectionPage> createState() => _OtherPaymentCollectionPageState();
}

class _OtherPaymentCollectionPageState extends State<OtherPaymentCollectionPage> with TickerProviderStateMixin {

 bool loading = false;

GetLmcFeaData searchList;

 ApiIntegration apiIntegration;
 GetLmcFeasibilityApiReqModel getLmcFeasibilityApiReqModel;

 AnimationController animationController;
  final bpNumberController = new TextEditingController();
  final crnNoController = new TextEditingController();
  final customerNameController = new TextEditingController();
  final addressController = new TextEditingController();
  final phoneNoController = new TextEditingController();

  String schema;
  loadLocalData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      schema = prefs.getString(GlobalConstants.schema) ?? "";

    });
  }


  Future searchBpNumber() async {
    setState(() {
      loading = true;
    });
    getLmcFeasibilityApiReqModel = GetLmcFeasibilityApiReqModel(
      schema: schema,
      bpNumber: bpNumberController.text.toString(),
    );
    var response = await apiIntegration.getLMCFesApi(getLmcFeasibilityApiReqModel);
    setState(() {
      try {
        searchList = response.rows;
        log("searchList"+searchList.toString());
        log("response"+response.toString());
        dataClear();
        crnNoController.text = searchList.crn.toString();
        customerNameController.text = searchList.firstName.toString() + " " +searchList.lastName.toString();
        addressController.text = searchList.address.toString();
        phoneNoController.text = searchList.phoneNumber.toString();


        // setState(() {
        //   loading = false;
        // });
      } catch (e) {
        setState(() {
          loading = false;
        });
      }
    });

    if (response.toString() != null) {
      setState(() {
        loading = false;
      });
      log("success");
    } else {
      setState(() {
        loading = false;
      });
      CustomToast.showToast("Failed");
      log("failed");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    animationController = AnimationController(duration: new Duration(seconds: 1), vsync: this);
    animationController.repeat();
    apiIntegration = ApiIntegration();
    loadLocalData();
  }
 @override
 void dispose() {
   // TODO: implement dispose
   super.dispose();
   animationController.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Payment Collection"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0,
                      vertical: 10),
                  child: TextFormField(
                    maxLength: 10,
                    enabled: true,
                    autofocus: true,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')),
                    ],
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.search,
                    controller: bpNumberController,
                    enableInteractiveSelection: true,
                    decoration: InputDecoration(
                      labelText: "BP Number",
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      suffixIcon: IconButton(
                        icon: loading
                            ? SizedBox(width: 12,
                            height: 12,
                            child: CircularProgressIndicator(
                                valueColor: animationController.drive(ColorTween(begin: Colors.green, end: Colors.red))
                            ))
                            : Icon(Icons.search_rounded),
                        onPressed: () {
                          searchBpNumber();
                        },
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10)),
                        borderSide: BorderSide(
                          color: Colors.grey, width: 1.0,),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey, width: 1.0,),
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: null == Colors.grey
                                ? Colors.teal
                                : Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                    ),

                  ),
                )
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: CustomTextEmailField(
                  enabled: true,
                  keyboardType: TextInputType.number,
                  controller: crnNoController,
                  validate: false,
                  labelText: "CRN No",
                  filledColor: Colors.white,
                )
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: CustomTextEmailField(
                  enabled: true,
                  keyboardType: TextInputType.name,
                  controller: customerNameController,
                  validate: false,
                  labelText: "Customer Name",
                  filledColor: Colors.white,
                )
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: CustomTextEmailField(
                  enabled: true,
                  keyboardType: TextInputType.text,
                  controller: addressController,
                  validate: false,
                  labelText: "Address",
                  filledColor: Colors.white,
                )
            ),
            Container(
                alignment: Alignment.bottomCenter,
                child: CustomTextEmailField(
                  enabled: true,
                  keyboardType: TextInputType.number,
                  controller: phoneNoController,
                  validate: false,
                  labelText: "Phone No",
                  filledColor: Colors.white,
                )
            ),
          ],
        ),
      ),

    );
  }

 dataClear() {
   crnNoController.clear();
   customerNameController.clear();
   phoneNoController.clear();
   addressController.clear();
 }
}
