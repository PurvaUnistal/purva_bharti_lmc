import 'package:lmc/model/lmc_model.dart';
import 'package:lmc/services/di.dart';

import '../repository/DataRepository.dart';

class LmcPresenter{
  LMCPresenterInterface _lmcPresenterInterface;
  DataRepository _dataRepository;
  LmcPresenter(this._lmcPresenterInterface){
    _dataRepository = new Injector().dataRepository;
  }
  getDataFromServer(String id, String schema, String token, String offSet,String selection,String bpNumber,String area_id) {

    assert(_lmcPresenterInterface !=null);
    _dataRepository.fetchLmcData(id,schema,token,offSet,selection,bpNumber,area_id).then((lmcList) =>
        _lmcPresenterInterface.showDataList(lmcList)).catchError((onError){
      _lmcPresenterInterface.showError(onError);
    });
  }
}
abstract class LMCPresenterInterface{
  void showDataList(List<Rows> lmcList);
  void showError([onError]);
}