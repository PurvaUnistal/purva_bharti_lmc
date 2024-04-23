import 'package:lmc/model/lmc_model.dart';
import 'package:http/http.dart' as http;
import '../ExportFile/export_file.dart';

class Service implements DataRepository{
  @override
  Future<List<Rows>> fetchLmcData(String id,String schema,String token,String offSet,String selection,String bpNumber, String area_id) {
    List<Rows> lmcDataList ;
    String _url = '';
    if(selection=='Feasibility')
      _url = GlobalConstants.getLmcApi+'?schema=$schema&user_id=$id&page=$offSet&bp_number=$bpNumber&area_id=$area_id';
    else if(selection=='Installation')
      _url = GlobalConstants.getlmcInstallationApi+'?schema=$schema&user_id=$id&page=$offSet&bp_number=$bpNumber&area_id=$area_id';
    else
      _url = GlobalConstants.getLmcApi+'?schema=$schema&user_id=$id&page=$offSet&area_id=$area_id';
    print("frgbhjkuyhungtreq-->${_url}");
    return http.get(Uri.parse(_url),headers: {'Authorization':'$token'}).then((value) async {
      JsonDecoder _decoder = new JsonDecoder();
      final jsonData = _decoder.convert(value.body);
      print("selection-->" +selection);
      print("_urlselection-->" +_url);
      print("getLmcApi-->" +value.body);
      print("lmcDataList--> ${jsonData.toString()}");
      int status = jsonData["success"];
      final statusCode = value.statusCode;
      print(value.body);
      if(statusCode<200 || statusCode>=300 || value.body==null){
        throw new FetchException('$statusCode');
        //throw new FetchException('Error while getting contact [StatusCode: $statusCode,Error:${value.reasonPhrase}');
      }
      if(status == 200){
        LmcData _lmcdata = LmcData.fromJson(json.decode(value.body));
        lmcDataList  = _lmcdata.data.rows;
      }
      return lmcDataList;
    });
  }

}