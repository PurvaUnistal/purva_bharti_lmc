import '../ExportFile/export_file.dart';

class HomeImagesScreen extends StatefulWidget {
  bool isEdit;
  int position = -1;
  ImageDataModel studentModel;

  HomeImagesScreen(this.isEdit, this.position, this.studentModel, {Key key})
      : super(key: key);

  @override
  State<HomeImagesScreen> createState() => _HomeImagesScreenState();
}

class _HomeImagesScreenState extends State<HomeImagesScreen> {
  TextEditingController bpNumberController = TextEditingController();
  TextEditingController lmcIDController = TextEditingController();
  TextEditingController dmaIDController = TextEditingController();
  PhotoController image1Controller = PhotoController();
  PhotoController image2Controller = PhotoController();
  PhotoController image3Controller = PhotoController();
  PhotoController image4Controller = PhotoController();

  String bpNumber = "";
  String lmcID = "";
  String dmaID = "";
  String pic1 = "";
  String pic2 = "";
  String pic3 = "";
  String pic4 = "";
  final String bpNoLabel = 'BP Number';
  Box<ImageDataModel> dataBox;
  bool selectImage = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataLoad();
    dataBox = Hive.box<ImageDataModel>(dataBoxName);
  }

  dataLoad() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      bpNumberController = TextEditingController(
          text: pref.getString(GlobalConstants.bpNumber) ?? "");
      lmcID = pref.getString(GlobalConstants.lmcId) ?? "";
      dmaID = pref.getString(GlobalConstants.dmaId) ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      bpNumberController.text = widget.studentModel.bpNumber;
      lmcIDController.text = widget.studentModel.lmcID;
      dmaIDController.text = widget.studentModel.dmaID;
      pic1 = widget.studentModel.image1 ?? "";
      pic2 = widget.studentModel.image2 ?? "";
      pic3 = widget.studentModel.image3 ?? "";
      pic4 = widget.studentModel.image4 ?? "";
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.green.shade800,
        title: Text("Image Store"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  controller: bpNumberController,
                  hintText: 'BP Number ',
                  labelText: "BP Number",
                  onChanged: (String val) {
                    bpNumber = val;
                    print("bpNumber-->" + bpNumber);
                  },
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            customCard("RFC Image"),
                            InkWell(
                              onTap: () =>
                                  _openImageSource1(context, image1Controller),
                              child: image1Controller.profileImage1 != null
                                  ? Image.file(
                                      image1Controller.profileImage1,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/place_holder.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Column(
                              children: [
                                customCard("GI Pipe Image"),
                                InkWell(
                                  onTap: () => _openImageSource2(
                                      context, image2Controller),
                                  child: image2Controller.profileImage2 != null
                                      ? Image.file(
                                          image2Controller.profileImage2,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          'assets/icons/place_holder.png',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            customCard("Isometric Image"),
                            InkWell(
                              onTap: () =>
                                  _openImageSource3(context, image3Controller),
                              child: image3Controller.profileImage3 != null
                                  ? Image.file(
                                      image3Controller.profileImage3,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/place_holder.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            customCard("Pneumatic Image"),
                            InkWell(
                              onTap: () =>
                                  _openImageSource4(context, image4Controller),
                              child: image4Controller.profileImage4 != null
                                  ? Image.file(
                                      image4Controller.profileImage4,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/icons/place_holder.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () => dialogBox(),
                  child: Text("Details"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  /////////////////////////////  image 1 ///////////////////////////////////////
  Future<void> _openImageSource1(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OpenImageSource(
          onTapGallery: () {
            Navigator.of(context).pop();
            getImage1(controller, ImageSource.gallery);
          },
          onTapCamera: () {
            Navigator.of(context).pop();
            getImage1(controller, ImageSource.camera);
          },
        );
      },
    );
  }

  Future<void> getImage1(
      PhotoController photoController, ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxHeight: 900,
          maxWidth: 1000,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          if (photoController != null) {
            photoController.profileImage1 = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      CustomToast.showToast(e.toString());
    }
  }

  /////////////////////////////  image 2 ///////////////////////////////////////
  Future<void> _openImageSource2(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OpenImageSource(
          onTapGallery: () {
            Navigator.of(context).pop();
            getImage2(controller, ImageSource.gallery);
          },
          onTapCamera: () {
            Navigator.of(context).pop();
            getImage2(controller, ImageSource.camera);
          },
        );
      },
    );
  }

  Future<void> getImage2(
      PhotoController photoController, ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxHeight: 900,
          maxWidth: 1000,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          if (photoController != null) {
            photoController.profileImage2 = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      CustomToast.showToast(e.toString());
    }
  }

  /////////////////////////////  image 3 ///////////////////////////////////////
  Future<void> _openImageSource3(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OpenImageSource(
          onTapGallery: () {
            Navigator.of(context).pop();
            getImage3(controller, ImageSource.gallery);
          },
          onTapCamera: () {
            Navigator.of(context).pop();
            getImage3(controller, ImageSource.camera);
          },
        );
      },
    );
  }

  Future<void> getImage3(
      PhotoController photoController, ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxHeight: 900,
          maxWidth: 1000,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null) {
          if (photoController != null) {
            photoController.profileImage3 = File(pickedFile.path);
          } else {
            print('No image selected.');
          }
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      CustomToast.showToast(e.toString());
    }
  }

  /////////////////////////////  image 4 ///////////////////////////////////////
  Future<void> _openImageSource4(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return OpenImageSource(
          onTapGallery: () {
            Navigator.of(context).pop();
            getImage4(controller, ImageSource.gallery);
          },
          onTapCamera: () {
            Navigator.of(context).pop();
            getImage4(controller, ImageSource.camera);
          },
        );
      },
    );
  }

  Future<void> getImage4(
      PhotoController photoController, ImageSource imageSource) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(
          source: imageSource,
          maxHeight: 900,
          maxWidth: 1000,
          imageQuality: 100);
      setState(() {
        if (pickedFile != null && photoController != null) {
          photoController.profileImage4 = File(pickedFile.path);
        } else {
          print('No image selected.');
        }
      });
    } catch (e) {
      CustomToast.showToast(e.toString());
    }
  }

  dialogBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
              child: Column(
            children: [
              ListTile(
                leading: Text("$bpNoLabel"),
                trailing: Text(
                    "${bpNumberController.text.toString() == null ? '-' : bpNumberController.text.toString()}"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard("RFC Image"),
                  image1Controller.profileImage1 == null
                      ? InkWell(
                          onTap: () =>
                              _openImageSource1(context, image1Controller),
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/icons/place_holder.png"),
                              fit: BoxFit.cover,
                            ),
                          )))
                      : ImageCircle(
                          fileImage1: image1Controller.profileImage1,
                          pathImage:
                              image1Controller.profileImage1.path.toString(),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard("Work Completed"),
                  image2Controller.profileImage2 == null
                      ? InkWell(
                          onTap: () =>
                              _openImageSource2(context, image2Controller),
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/icons/place_holder.png"),
                              fit: BoxFit.cover,
                            ),
                          )))
                      : ImageCircle(
                          fileImage1: image2Controller.profileImage2,
                          pathImage:
                              image2Controller.profileImage2.path.toString(),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard("Isometric Image"),
                  image3Controller.profileImage3 == null
                      ? InkWell(
                          onTap: () =>
                              _openImageSource3(context, image3Controller),
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/icons/place_holder.png"),
                              fit: BoxFit.cover,
                            ),
                          )))
                      : ImageCircle(
                          fileImage1: image3Controller.profileImage3,
                          pathImage:
                              image3Controller.profileImage3.path.toString(),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  customCard("Pneumatic Image"),
                  image4Controller.profileImage4 == null
                      ? InkWell(
                          onTap: () =>
                              _openImageSource4(context, image4Controller),
                          child: Container(
                              decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage("assets/icons/place_holder.png"),
                              fit: BoxFit.cover,
                            ),
                          )))
                      : ImageCircle(
                          fileImage1: image4Controller.profileImage4,
                          pathImage:
                              image4Controller.profileImage4.path.toString(),
                        ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          )),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    child: Text("Save"),
                    onPressed: () async {
                      storeRecords();
                    }),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Edit'),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  storeRecords() {
    var getBPNumber = bpNumberController.text;
    var getLmcID = lmcID;
    var getDmaID = dmaID;
    var getImage1 = "", getImage2 = "", getImage3 = "", getImage4 = "";
    if (image1Controller.profileImage1 != null) {
      getImage1 = image1Controller.profileImage1.path.toString() ?? "";
    }
    if (image2Controller.profileImage2 != null) {
      getImage2 = image2Controller.profileImage2.path.toString() ?? "";
    }
    if (image3Controller.profileImage3 != null) {
      getImage3 = image3Controller.profileImage3.path.toString() ?? "";
    }
    if (image4Controller.profileImage4 != null) {
      getImage4 = image4Controller.profileImage4.path.toString() ?? "";
    }
    if (getBPNumber.isNotEmpty & getLmcID.isNotEmpty & getDmaID.isNotEmpty) {
      ImageDataModel data = ImageDataModel(
        bpNumber: getBPNumber,
        lmcID: getLmcID,
        dmaID: getDmaID,
        image1: getImage1 ?? "",
        image2: getImage2 ?? "",
        image3: getImage3 ?? "",
        image4: getImage4 ?? "",
      );
      if (data.image1.isNotEmpty ||
          data.image2.isNotEmpty ||
          data.image3.isNotEmpty ||
          data.image4.isNotEmpty == true) {
        print("save");
        if (widget.isEdit) {
          dataBox.putAt(widget.position, data);
        } else {
          dataBox.add(data);
        }
        EasyLoading.showSuccess('Great Success! \n Record Save');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageListScreen()));
      } else {
        print("not save");
        CustomToast.showToast("Please select at least one image");
        Navigator.of(context).pop();
      }
    } else {
      print("hii");
    }
  }
}
