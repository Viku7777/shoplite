import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/presentation/Screen/Auth/view/splash_view.dart';
import 'package:shoplite/utils/di_injections.dart';
import 'package:shoplite/utils/theme/app_theme.dart';

final providerContainer = ProviderContainer();
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // init local database
  await LocalDataSource.initLocalDataSource();
  // init DI Injections
  await initDependencies();
  runApp(
    UncontrolledProviderScope(container: providerContainer, child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return ValueListenableBuilder(
            valueListenable: themeNotifier,
            builder:
                (context, value, child) => MaterialApp(
                  title: 'Shoplite',
                  theme: AppTheme.lightTheme,
                  themeMode: value,
                  darkTheme: AppTheme.darkTheme,
                  home: SplashView(),
                ),
          );
        },
      ),
    );
  }
}
