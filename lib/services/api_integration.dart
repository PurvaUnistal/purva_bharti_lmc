import 'dart:developer';
import 'package:http/http.dart' as http;
import '../model/lmc_installation_done_model.dart';
import '../../ExportFile/export_file.dart';

class ApiIntegration{

  Future<List<Rows>> installDoneApi(InstallDoneResModel installDoneResModel, int page) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String schema = prefs.getString(GlobalConstants.schema);
    String userId = prefs.getString(GlobalConstants.id);
    String url = GlobalConstants.getLmcInstallationDone+"schema=$schema&user_id=$userId&page=$page";
    print("uri----->$url");
    var res = await http.get(Uri.parse(url));
    print("getLmcInstallationDone--->" +res.body);
    try  {
      if (res.statusCode == 200) {
        LmcInstallationDoneModel lmc = LmcInstallationDoneModel.fromJson(jsonDecode(res.body.toString()));
        return lmc.data.rows;
      }  else {
        throw Exception('Failed to load album');
      }
    }
    catch(e) {
      throw Exception(e);
    }
  }

  Future<ChangePasswordModel> changePasswordApi(ChangePasswordResponse changePasswordResponse)async{
    String url = GlobalConstants.resetPassword;
    var res = await ApiHelper.postData(url: url, body: changePasswordResponse.toJson());
    try{
      if(res != null){
        return ChangePasswordModel.fromJson(res);
      } else{
        print("Null Data");
      }
    }catch(e){
      print(e.toString());
      CustomToast.showToast(e.toString());
    }
    return null;
  }


  Future<InstallationImagesModel> lmcInstallationImages(InstallationImagesReqModel installationImagesReqModel) async{
    String url = GlobalConstants.updateLMCInstallationImages;
    print("uri----->$url");
    try {
      var request = await http.MultipartRequest("Post", Uri.parse(url));
      Map<String, String> requestBody = <String, String>{
        "schema": installationImagesReqModel.schema,
        "bpNumber": installationImagesReqModel.bpNumber,
        "lmc_id": installationImagesReqModel.lmcId,
        "dma_id": installationImagesReqModel.dmaId
      };
      request.fields.addAll(requestBody);
      if (installationImagesReqModel.rfcForm.isNotEmpty) {
        var rfcFormImage = await http.MultipartFile.fromPath("rfc_form", installationImagesReqModel.rfcForm);
        request.files.add(rfcFormImage);
        print("rfcFormImage-->" + rfcFormImage.toString());
      } else {
        request.fields[ "rfc_form"] = "";
      }
      if (installationImagesReqModel.workCompletedImage.isNotEmpty) {
        var workCompletedImage = await http.MultipartFile.fromPath("work_completed_image", installationImagesReqModel.workCompletedImage);
        request.files.add(workCompletedImage);
        print("workCompletedImage-->" + workCompletedImage.toString());
      } else {
        request.fields["work_completed_image"] = "";
      }
      if (installationImagesReqModel.isometricImage.isNotEmpty) {
        var isometricImage = await http.MultipartFile.fromPath("isometric_image", installationImagesReqModel.isometricImage);
        request.files.add(isometricImage);
        print("isometricImage-->" + isometricImage.toString());
      } else {
        request.fields["isometric_image"] = "";
      }
      if (installationImagesReqModel.pneumaticImage.isNotEmpty) {
        var pneumaticImage = await http.MultipartFile.fromPath("pneumatic_image", installationImagesReqModel.pneumaticImage);
        request.files.add(pneumaticImage);
        print("pneumaticImage-->" + pneumaticImage.toString());
      } else {
        request.fields["pneumatic_image"] = "";
      }
      print("Request" + requestBody.toString());
      var response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print("Response-->" + response.toString() + "responseString :" + responseString);
      try {
        if (response.statusCode == 200) {
          return InstallationImagesModel.fromJson(json.decode(responseString));
        }
        else {
          throw Exception('Failed to load data!');
        }
      } catch(e){
        throw Exception('Failed to load data!');
      }
    }catch(exception )
    {
      print("request exception-->"+ exception.toString());
    }
  }


  Future<RowsData> getLMCFesApi(GetLmcFeasibilityApiReqModel getLmcFeasibilityApiReqModel) async{
    String queryString = Uri(queryParameters: getLmcFeasibilityApiReqModel.toJson()).query;
    var billsMeterReaderUrl =GlobalConstants.getLmcFeasibilityAPI +'?' + queryString;
    log("getPendingBillsMeterReader-->"+ billsMeterReaderUrl);
    var response = await http.get(Uri.parse(billsMeterReaderUrl));
    log("getPendingBillsMeterReader--->" + response.body);
    try {
      if (response.statusCode == 200) {
        GetLmcFeasibilityApiModel resp = GetLmcFeasibilityApiModel.fromJson(jsonDecode(response.body.toString()));
        return resp.data;
      } else if (response.statusCode == 500) {
        GetLmcFeasibilityApiModel resp = GetLmcFeasibilityApiModel.fromJson(jsonDecode(response.body.toString()));
        print("500-->" + resp.data.toString());
     //   ShowCustomToast.showToast(resp.data.toString());
        return resp.data;
      } else if (response.statusCode == 400) {
        GetLmcFeasibilityApiModel resp = GetLmcFeasibilityApiModel.fromJson(jsonDecode(response.body.toString()));
        log("400-->" + resp.data.toString());
      //  ShowCustomToast.showToast(resp.data.toString());
        return resp.data;
      }
    }
    catch (e) {
      log('catch error--> : $e');
    }

  }




}