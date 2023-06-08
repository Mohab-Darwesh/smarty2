import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graduation_project/controllers/auth_controller.dart';
import 'package:graduation_project/controllers/language_controller.dart';
import 'package:graduation_project/shared/cache_helper/cache_helper.dart';
import 'package:graduation_project/shared/constatns/app_strings.dart';
import 'package:graduation_project/shared/route_helper/route_helper.dart';
import 'language/app_localization.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  //to remove local storage
  // CacheHelper.remove(key: 'student');
  // CacheHelper.remove(key: 'onBoarding');
  // CacheHelper.remove(key: 'student');
  //to remove status bar
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   Get.put(LanguageController());
   Get.put(AuthController());
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smarty',
        // home: const HomeScreen(),
        theme: ThemeData(),
        locale: Locale(CacheHelper.getData(key: 'lang') ?? arb),
        fallbackLocale: Locale(arb),
        translations: AppLocalization(),
        initialRoute: RouteHelper.getSplashPage(),
        getPages: RouteHelper.getRoutes(),
        textDirection: Get.find<LanguageController>().locale != eng
            ? TextDirection.rtl
            : TextDirection.ltr,
      ),
    );
  }
}
