import '../ExportFile/export_file.dart';
import '../model/lmc_installation_done_model.dart';
import 'home_images.dart';

class BPListDataImagePage extends StatefulWidget {
  const BPListDataImagePage({Key key}) : super(key: key);

  @override
  State<BPListDataImagePage> createState() => _BPListDataImagePageState();
}

class _BPListDataImagePageState extends State<BPListDataImagePage> {


  int pageNumber = 1;
  String schema= "";
  String userId = "";
  bool _showProgress = false;
  bool isLastPage = false;
  bool _loadMore = false;
  BuildContext mContext;
  ApiIntegration apiIntegration;
  InstallDoneResModel installDoneResModel;
  List<Rows> rowDataList = [], searchRowList = [];
  BuildContext ctx;
  bool canProceed = true;
  bool isOffline = false;
  bool dialogIsVisible = false;
  bool checkLoading = true;
  final Connectivity _connectivity = Connectivity();


  ScrollController _scrollController = new ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSchema();
    initConnectivity();
    apiIntegration = ApiIntegration();
    fetchInstallDoneResModel();
    _scrollController.addListener((){
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        pageNumber ++;
        setState(() {
        //  _loadMore = true;
        });
        print("pageNumber ++ --->" +pageNumber.toString());
        fetchInstallDoneResModel();
      }
      else if (_scrollController.position.pixels == _scrollController.position.minScrollExtent) {
        pageNumber --;
        setState(() {
        //  _loadMore = true;
        });
        print("pageNumber -- --->" +pageNumber.toString());
        fetchInstallDoneResModel();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  loadSchema() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      schema = prefs.getString(GlobalConstants.schema) ?? '';
      userId = prefs.getString(GlobalConstants.id) ?? '';
      print("schema--->" + schema);
      print("userId--->" + userId);
    });
  }

  Future fetchInstallDoneResModel() async{
    setState(() {
      _showProgress = true;
    });
    installDoneResModel = InstallDoneResModel(
      schema: schema,
      userId: userId,
    );
    var response  = await apiIntegration.installDoneApi(installDoneResModel,pageNumber);
      setState(() {
        rowDataList = response;
        searchRowList = rowDataList;
      });
    print(response);
    if(response != null){
      setState(() {
        _showProgress = false;
      });
      print("success");
    } else{
      _showProgress = false;
      print("fails");
    }
    //  return ;
  }
  Box<ImageDataModel> dataBox = Hive.box<ImageDataModel>(dataBoxName);

  @override
  Widget build(BuildContext context) {
    mContext = context;
    double _width = MediaQuery. of(context). size. width/4;
    return Scaffold(

      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("BP Number List"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  keyboardType:TextInputType.number,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding:EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.grey,),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      borderSide: BorderSide(color: Colors.blue,),
                    ),
                    suffixIcon:Icon(Icons.search),
                    hintText: 'Search ',
                  ),
                  onChanged: onSearchTextChanged,
                ),
                SizedBox(height: 10,),
                Container(
                  height: 50,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: _width, child: Center(child: Text('SR NO.',style: AppTextStyle.bpNoTable,),),),
                        //   Container(width: _width, child: Center(child: Text('Area',style: AppTextStyle.bpNoTable,),),),
                        Container(width: _width, child: Center(child: Text('BP Number',style: AppTextStyle.bpNoTable,),),),
                      ],
                    ),
                  ),

                ),
                ( _showProgress)
                    ? Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Wrap(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 5,),
                            child: SizedBox(
                              child: CircularProgressIndicator(strokeWidth: 3,),
                              height: 20.0, width: 20.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text('Wait..',),
                          )
                        ],
                      ),
                    ),
                  ),
                ):
                ( rowDataList.length > 0)
                    ? searchRowList.length>0
                    ? Expanded(
                      child: ListView.builder(
                           controller: _scrollController,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: searchRowList.length,
                            itemBuilder: (BuildContext context,int index){
                              Rows _rows = searchRowList.elementAt(index);
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var bpn = _rows.bpNumber.toString();
                                      var n =  dataBox.length;
                                      bool b = false;
                                      for(int i=0;i<n;i++){
                                        var m = dataBox.getAt(i).bpNumber;
                                        if(m == bpn){
                                          CustomToast.showToast("BP Number Record Already Exist");
                                          b = true;
                                          break;
                                        }
                                      }
                                      if(!b){
                                        SharedPreferences prefsimage = await SharedPreferences.getInstance();
                                        prefsimage.setString(GlobalConstants.bpNumber,_rows.bpNumber);
                                        prefsimage.setString(GlobalConstants.lmcId,_rows.id);
                                        prefsimage.setString(GlobalConstants.dmaId,_rows.dmaId);
                                        Navigator.push(context,MaterialPageRoute(builder: (context) =>HomeImagesScreen(false,-1,null)));
                                       }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 15),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              width: _width,
                                              child: Center(
                                                 child: Text((rowDataList.indexOf(_rows) +1+(pageNumber-1)*10).toString(),style: AppTextStyle.textTitle,))),
                                               //   child: Text($index,style: AppTextStyle.textTitle,))),
                                          //     Container(width: _width,child: Center(child: Text(userId,style: AppTextStyle.textTitle,))),
                                          Container(
                                              width: _width,
                                              child: Center(child: Text(_rows.bpNumber,style: AppTextStyle.textTitle,))),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.blue,
                                  ),
                                ],
                              );
                              //  }
                              // return new LmcListItem(rows: _rows,);
                            }
                      ),
                    )
                    :Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Text("No matching records found"),
                )
                    :Padding(
                  padding: const EdgeInsets.only(top: 200.0),
                  child: Center(child: Text('Data Not Found'),),
                ),
              ],
            ),

          ),
          _loadMore ?Center(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Padding(
                  padding: EdgeInsets.all(10,),
                  child: Text('No Data',),
                ),
              ),
            ),
          ) :Container()
        ],
      ),
    );
  }
  List<Rows> _searchResult = [];
  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.trim().isEmpty) {
      setState(() {
        rowDataList = rowDataList;
        print("searchRowList(empty)--> " +rowDataList.toString());
      });
      return;
    }

    rowDataList.forEach((userDetail) {
      if (userDetail.bpNumber.contains(text.trim()))
        _searchResult.add(userDetail);
      print(userDetail.bpNumber);
    });

    setState(() {
      searchRowList = _searchResult;
      print(_searchResult.toString());
    });
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
    EasyLoading.dismiss();
    switch (result) {
      case ConnectivityResult.wifi:
        if (!mounted) return;
        setState(() {
          isOffline = false;
          dialogIsVisible = false;
          checkLoading=true;
          //  callInit();
        });
        break;
      case ConnectivityResult.mobile:
        if (!mounted) return;
        setState(() {
          isOffline = true;
          dialogIsVisible = false;
          checkLoading=true;
          //  callInit();
        });
        break;
      case ConnectivityResult.wifi:
        if (!mounted) return;
        setState(() {
          isOffline = false;
          dialogIsVisible = false;
          checkLoading=true;
          //  callInit();
        });
        break;
      case ConnectivityResult.mobile:
        if (!mounted) return;
        setState(() {
          isOffline = true;
          dialogIsVisible = false;
          checkLoading=true;
          //  callInit();
        });
        break;
      case ConnectivityResult.none:
        if (!mounted) return;
        setState(() {
          isOffline = true;
          checkLoading=true;
          //   callInit();
          EasyLoading.dismiss();
          //   print("TASKID $_tasks");
          EasyLoading.showError("ERROR!!!!!\n INTERNET DISCONNECTED");
          checkLoading = true;
        });
        break;
      default: if (!mounted) return;
      setState(() => isOffline = true);
      break;
    }
  }

}
