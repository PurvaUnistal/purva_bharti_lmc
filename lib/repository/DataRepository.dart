
import 'package:lmc/model/lmc_model.dart';


abstract class DataRepository{
  Future<List<Rows>> fetchLmcData(String id,String schema, String token, String offSet,String selection,String bpNumber,String area_id);
}