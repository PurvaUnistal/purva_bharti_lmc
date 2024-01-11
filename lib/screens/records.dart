import '../ExportFile/export_file.dart';

class CustomerRecords extends StatefulWidget {
  const CustomerRecords({Key key}) : super(key: key);

  @override
  State<CustomerRecords> createState() => _CustomerRecordsState();
}

class _CustomerRecordsState extends State<CustomerRecords> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Do something here
        print("After clicking the Android Back Button");
        //  return Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (_) =>  DashboardScreen()),(r) => false);
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green.shade800,
            title: Text("Data"),
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: Border(
                    left: BorderSide(color: Colors.green.shade800, width: 15),
                    right: BorderSide(color: Colors.yellow.shade800, width: 15),
                  ),
                  elevation: 5,
                  shadowColor: Colors.green.shade500,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _itemList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          return _itemList[index];
                        }),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  get _itemList {
    List<Widget> list = [];
    list.add(
        listItem("", "LMC Images", icon: Icons.list_alt_outlined, click: () {
      showView(BPListDataImagePage());
    }));
    list.add(listItem("", "View and Sync Records", icon: Icons.sync, click: () {
      showView(ImageListScreen());
    }));
    return list;
  }

  showView(Object object) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => object,
        ));
    print("result $result");
    if (result is Map<String, dynamic>) {
      getBundle(result);
    } else
      getBundle(null);
    return result;
  }

  getBundle(Map<String, dynamic> bundle) {}
  listItem(step, title, {icon, color, Function click}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 90,
        child: Card(
          elevation: 8,
          child: InkWell(
            onTap: () {
              if (click != null) click.call();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                icon != null
                    ? Container(
                        padding: EdgeInsets.all(11),
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.grey)),
                        child: new Icon(
                          icon,
                          color: color ?? Theme.of(context).primaryColor,
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    : Container(),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Text(step,
                      style: TextStyle(
                          color: Colors.green, fontStyle: FontStyle.italic),
                      textAlign: TextAlign.end),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
