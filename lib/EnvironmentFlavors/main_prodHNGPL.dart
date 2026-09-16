import 'package:flutter/cupertino.dart';
import 'package:lmc/Utils/common_widgets/res/enums.dart';
import 'package:lmc/Utils/common_widgets/res/environment_config.dart';
import 'package:lmc/root.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var configurationApp = EnvironmentConfig(
    child: Root(client: Client.hngpl),
    flavors: EnvironmentFlavors.prodHNGPL,
  );
  runApp(configurationApp);
}
