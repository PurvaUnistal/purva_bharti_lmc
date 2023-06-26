import '../ExportFile/export_file.dart';


class CustomLoaderDialog {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              SpinKitFadingCircle(
                                color: Colors.teal,
                                size: 50.0,),
                              SizedBox(height: 20,),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Please Wait",style: TextStyle(color:Colors.black,fontSize: 16),),
                              ),
                              SizedBox(height: 20,),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]));
        });
  }
}