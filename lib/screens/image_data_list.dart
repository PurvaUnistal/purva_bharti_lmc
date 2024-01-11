import 'package:flutter/scheduler.dart';
import '../ExportFile/export_file.dart';

class ImageListScreen extends StatefulWidget {
  const ImageListScreen({Key key}) : super(key: key);

  @override
  State<ImageListScreen> createState() => _ImageListScreenState();
}

class _ImageListScreenState extends State<ImageListScreen> {
  String schema = "";
  String uploadText = "UPLOAD DATA";
  String wiFIText = "WI-FI";
  String mobileText = "MOBILE DATA";

  bool canProceed = true;
  bool isOffline = false;
  bool checkLoading = false;
  bool checkWIFIStatus = false;
  bool dialogIsVisible = false;
  bool checkMobileStatus = false;
  bool checkOutBtnBoth = false;

  BuildContext ctx;
  Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> connectivitySubscription;

  ApiIntegration apiIntegration;
  InstallationImagesReqModel installationImagesReqModel;

  Map<dynamic, dynamic> raw;
  Box<ImageDataModel> dataBox;
  List<ImageDataModel> localList;

  GlobalKey<FormState> _keyLoader = GlobalKey<FormState>();

  @override
  void initState() {
    initConnectivity();
    super.initState();
    loadSchema();
    apiIntegration = ApiIntegration();
    connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    dataBox = Hive.box<ImageDataModel>(dataBoxName);
    localList = dataBox.values.toList();
  }

  loadSchema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      schema = prefs.getString(GlobalConstants.schema) ?? '';
      print(schema);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return WillPopScope(
      onWillPop: () async {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => CustomerRecords()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green.shade800,
          title: const Text("LMC Images"),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Card(
                color: Colors.white,
                elevation: 5,
                shadowColor: Colors.white,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ReusedBox(
                      color: checkMobileStatus ? Colors.green : Colors.red,
                      text: mobileText,
                    ),
                    ReusedBox(
                      color: checkWIFIStatus ? Colors.green : Colors.red,
                      text: wiFIText,
                    ),
                    checkLoading
                        ? ReusedBox(
                            color: checkOutBtnBoth ? Colors.green : Colors.red,
                            text: uploadText,
                          )
                        : InkWell(
                            child: ReusedBox(
                              color:
                                  checkOutBtnBoth ? Colors.green : Colors.red,
                              text: uploadText,
                            ),
                            onTap: () async {
                              if (checkOutBtnBoth) {
                                int count = 0;
                                CustomLoaderDialog.showLoadingDialog(
                                    context, _keyLoader);
                                for (int i = 0; i < localList.length; i++) {
                                  ImageDataModel getStudent = localList[i];
                                  installationImagesReqModel =
                                      InstallationImagesReqModel(
                                    schema: schema,
                                    bpNumber: getStudent.bpNumber,
                                    lmcId: getStudent.lmcID,
                                    dmaId: getStudent.dmaID,
                                    rfcForm: getStudent.image1,
                                    workCompletedImage: getStudent.image2,
                                    isometricImage: getStudent.image3,
                                    pneumaticImage: getStudent.image4,
                                  );
                                  print("installationImagesReqModel--->");
                                  print(installationImagesReqModel.toJson());
                                  try {
                                    var response = await apiIntegration
                                        .lmcInstallationImages(
                                            installationImagesReqModel);
                                    print(response.toString());
                                    if (response != null &&
                                        response.success == 200) {
                                      setState(() {
                                        print("response---->" + response.data);
                                        checkLoading = true;
                                        count++;
                                      });
                                      //  EasyLoading.showSuccess('Great Success! \n Record Save');
                                    } else {
                                      print("response---->" + response.data);
                                      EasyLoading.showError('Failed to save');
                                    }
                                  } catch (e) {
                                    EasyLoading.showError(e.toString());
                                  }
                                }
                                for (int i = count - 1; i >= 0; i--) {
                                  await dataBox.deleteAt(i);
                                }
                                if (count == localList.length) {
                                  EasyLoading.showSuccess(
                                      'Great Success! \n Record Save');
                                  await dataBox.clear();
                                }
                                localList.removeRange(0, count);
                                Navigator.of(_keyLoader.currentContext,
                                        rootNavigator: true)
                                    .pop();
                                EasyLoading.dismiss();
                              }
                            }),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: ValueListenableBuilder(
                          valueListenable: dataBox.listenable(),
                          builder: (context, box, _) {
                            return dataBox.length == 0
                                ? Center(child: Text("NO RECORDS FOUNDS"))
                                : ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: localList.length,
                                    itemBuilder: (context, position) {
                                      ImageDataModel getStudent =
                                          localList[position];
                                      return Visibility(
                                        visible: true,
                                        child: Card(
                                          elevation: 8,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 12),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      ListTile(
                                                        title: Text(
                                                          "RECORDS : ${position + 1}",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                        ),
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: 0,
                                                                vertical: -4),
                                                        trailing: IconButton(
                                                          icon: checkLoading
                                                              ? Icon(
                                                                  Icons.sync,
                                                                  color: Colors
                                                                      .red,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .sync_outlined,
                                                                  color: Colors
                                                                      .green),
                                                          onPressed: () async {
                                                            CustomLoaderDialog
                                                                .showLoadingDialog(
                                                                    context,
                                                                    _keyLoader);
                                                            if (checkOutBtnBoth) {
                                                              installationImagesReqModel =
                                                                  InstallationImagesReqModel(
                                                                schema: schema,
                                                                bpNumber:
                                                                    getStudent
                                                                        .bpNumber,
                                                                lmcId:
                                                                    getStudent
                                                                        .lmcID,
                                                                dmaId:
                                                                    getStudent
                                                                        .dmaID,
                                                                rfcForm: getStudent
                                                                    .image1
                                                                    .toString(),
                                                                workCompletedImage:
                                                                    getStudent
                                                                        .image2
                                                                        .toString(),
                                                                isometricImage:
                                                                    getStudent
                                                                        .image3
                                                                        .toString(),
                                                                pneumaticImage:
                                                                    getStudent
                                                                        .image4
                                                                        .toString(),
                                                              );
                                                              print(
                                                                  "installationImagesReqMode-->");
                                                              print(
                                                                  installationImagesReqModel
                                                                      .toJson());
                                                              try {
                                                                var response =
                                                                    await apiIntegration
                                                                        .lmcInstallationImages(
                                                                            installationImagesReqModel);
                                                                print(response
                                                                    .data);
                                                                print(response
                                                                    .toString());
                                                                if (response !=
                                                                        null &&
                                                                    response.success ==
                                                                        200) {
                                                                  setState(() {
                                                                    checkLoading =
                                                                        false;
                                                                  });
                                                                  localList
                                                                      .removeAt(
                                                                          position);
                                                                  dataBox.deleteAt(
                                                                      position);
                                                                  EasyLoading
                                                                      .showSuccess(
                                                                          'Great Success! \n Record Save');
                                                                } else {
                                                                  EasyLoading
                                                                      .showError(
                                                                          'Failed to save');
                                                                }
                                                              } catch (e) {
                                                                EasyLoading
                                                                    .showError(e
                                                                        .toString());
                                                              }
                                                            }
                                                            Navigator.of(
                                                                    _keyLoader
                                                                        .currentContext,
                                                                    rootNavigator:
                                                                        true)
                                                                .pop();
                                                            EasyLoading
                                                                .dismiss();
                                                          },
                                                        ),
                                                      ),
                                                      ListTile(
                                                        visualDensity:
                                                            VisualDensity(
                                                                horizontal: 0,
                                                                vertical: -4),
                                                        title:
                                                            Text("BP Number"),
                                                        trailing: Text(
                                                          getStudent.bpNumber,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 18),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              getStudent.image1 !=
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundImage: FileImage(File(getStudent
                                                                          .image1
                                                                          .toString())))
                                                                  : Text(
                                                                      "No Image"),
                                                              const SizedBox(
                                                                  width: 10),
                                                              getStudent.image2 !=
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundImage: FileImage(File(getStudent
                                                                          .image2
                                                                          .toString())))
                                                                  : Text(
                                                                      "No Image"),
                                                              const SizedBox(
                                                                  width: 10),
                                                              getStudent.image3 !=
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundImage: FileImage(File(getStudent
                                                                          .image3
                                                                          .toString())))
                                                                  : Text(
                                                                      "No Image"),
                                                              const SizedBox(
                                                                  width: 10),
                                                              getStudent.image4 !=
                                                                      null
                                                                  ? CircleAvatar(
                                                                      backgroundImage: FileImage(File(getStudent
                                                                          .image4
                                                                          .toString())))
                                                                  : Text(
                                                                      "No Image"),
                                                            ],
                                                          ),
                                                          checkLoading
                                                              ? Icon(
                                                                  Icons.delete)
                                                              : IconButton(
                                                                  icon: Icon(Icons
                                                                      .delete),
                                                                  onPressed:
                                                                      () async {
                                                                    Widget
                                                                        okButton =
                                                                        TextButton(
                                                                      child: Text(
                                                                          "OK"),
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            false);
                                                                        localList
                                                                            .removeAt(position);
                                                                        dataBox.deleteAt(
                                                                            position);
                                                                      },
                                                                    );
                                                                    Widget
                                                                        noButton =
                                                                        TextButton(
                                                                      child: Text(
                                                                          "NO"),
                                                                      onPressed: () => Navigator.pop(
                                                                          context,
                                                                          false),
                                                                    );
                                                                    AlertDialog
                                                                        alert =
                                                                        AlertDialog(
                                                                      title: Text(
                                                                          "PBG DMA"),
                                                                      content: Text(
                                                                          "Are you sure delete records ?"),
                                                                      actions: [
                                                                        noButton,
                                                                        okButton,
                                                                      ],
                                                                    );
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return alert;
                                                                      },
                                                                    );
                                                                  },
                                                                )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                          }))),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return;
    }
    _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        setState(() {
          isOffline = false;
          dialogIsVisible = false;
          checkWIFIStatus = true;
          checkOutBtnBoth = true;
        });
        break;
      case ConnectivityResult.mobile:
        setState(() {
          isOffline = false;
          dialogIsVisible = false;
          checkOutBtnBoth = true;
          checkMobileStatus = true;
        });
        break;
      case ConnectivityResult.none:
        setState(() {
          isOffline = true;
          checkOutBtnBoth = false;
          checkMobileStatus = false;
          checkWIFIStatus = false;
        });
        buildAlertDialog("Internet connection cannot be established!");
        break;
      default:
        setState(() => isOffline = true);
        break;
    }
  }

  void buildAlertDialog(String message) {
    SchedulerBinding.instance.addPostFrameCallback((_) => setState(() {
          if (isOffline && !dialogIsVisible) {
            dialogIsVisible = true;
            showDialog(
                barrierDismissible: false,
                context: ctx,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.portable_wifi_off,
                          color: Colors.redAccent,
                          size: 36.0,
                        ),
                        canProceed
                            ? Text(
                                "Check your internet connection before proceeding.",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12.0),
                              )
                            : Text(
                                "Please! proceed by connecting to a internet connection",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.red),
                              ),
                      ],
                    ),
                    actions: <Widget>[
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: () {
                          SystemChannels.platform
                              .invokeMethod('SystemNavigator.pop');
                        },
                        child: Text("CLOSE THE APP",
                            style: TextStyle(color: Colors.white)),
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () {
                          if (isOffline) {
                            setState(() {
                              canProceed = false;
                            });
                          } else {
                            // canProceed = true;
                            Navigator.pop(ctx);
                          }
                        },
                        child: Text("PROCEED",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  );
                });
          }
        }));
  }
}
