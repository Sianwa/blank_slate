import 'package:blank_slate/api/repositories/sampleRepository.dart';
import 'package:blank_slate/utils/services/notification_service.dart';
import 'package:blank_slate/utils/services/shared_pref_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future setUpLocator() async{
  //repositories
  locator.registerFactory(() => SampleRepository());

  //utils
  locator.registerFactory(() => NotificationService());

  //shared preference
  var instance = await SharedPrefService.getInstance();
  locator.registerSingleton<SharedPrefService>(instance);

}