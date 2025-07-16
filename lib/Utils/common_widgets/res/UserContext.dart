import 'package:lmc/features/Login/domain/model/login_model.dart';

import 'app_config.dart';

class UserContext {
  final LoginModel loginModel;
  final User user;

  UserContext({required this.loginModel,required this.user});
  static UserContext getUserContext() {
    final appConfig = AppConfig.instanceInit();
    final loginModel = appConfig?.loginData;
    final user = loginModel!.user;

    return UserContext(
      loginModel: loginModel,
      user: user ?? User(),
    );
  }
}
