import 'package:get_it/get_it.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/data/network/network_api_services.dart';
import 'package:shoplite/domain/repositories/auth_repo/auth_repo.dart';
import 'package:shoplite/domain/repositories/home_repo/home_repo.dart';

final sI = GetIt.instance; // "sl" = service locator

Future<void> initDependencies() async {
  sI.registerSingleton<NetworkApiServices>(NetworkApiServices());
  sI.registerSingleton<AuthRepo>(AuthRepo());
  sI.registerSingleton<HomeRepo>(HomeRepo());
  sI.registerSingleton<LocalDataSource>(LocalDataSource());
}
