import 'package:sumittask9dot/app/data/res/app.export.dart';

late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X design base (you can change)
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "Task",
          initialRoute: prefs.getString(LocalStorage.loginKey.toString()) != null
              ? Routes.HOME_PAGE
              : AppPages.INITIAL,
          getPages: AppPages.routes,
          navigatorKey: NavigationService.navigatorKey,
          scaffoldMessengerKey: AppToast.snackBarKey,
          debugShowCheckedModeBanner: false,
          defaultTransition: Transition.downToUp,
          transitionDuration: const Duration(milliseconds: 600),
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor:AppColors.white,
            splashFactory: NoSplash.splashFactory,
            splashColor: AppColors.transparent,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: Colors.black,
              selectionColor: Colors.grey,
              selectionHandleColor: Colors.blue,
            ),
          ),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            overscroll: false,
            physics: const BouncingScrollPhysics(),
          ),
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(1.0),
              ),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: child!,
              ),
            );
          },
          home: child,
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
