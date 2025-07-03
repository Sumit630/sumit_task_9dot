import '../res/app.export.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  /// Navigate to a named route with a fade transition
  static Future<dynamic> getToRoute(String Routes, {dynamic arguments}) async {
    return Get.toNamed(Routes, arguments: arguments);
  }

  static Future<dynamic> downToupRouteToNamed(String Routes,
      {dynamic arguments}) async {
    return Get.to(_getPage(Routes),
        arguments: arguments,
        transition: Transition.downToUp,
        fullscreenDialog: true,
        duration: Duration(milliseconds: 400));
    // return navigatorKey.currentState?.push(_slideUpRoute(Routes, arguments: arguments));
  }

  /// Clear all routes and navigate to a named route with a fade transition
  static Future<dynamic> replaceAll(String Routes, {dynamic arguments}) async {
    return Get.offAllNamed(Routes, arguments: arguments);
  }

  /// Navigate back
  static dynamic goBack({var result}) {
    return Get.back(result: result);
  }

  /// Fade transition route generator

  // static PageRouteBuilder _slideUpRoute(String route, {dynamic arguments}) {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => _getPage(route),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.0, 1.0); // Start from below the screen
  //       const end = Offset.zero; // End at the current position
  //       const curve = Curves.easeInOut;
  //       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  //       var offsetAnimation = animation.drive(tween);
  //       return SlideTransition(position: offsetAnimation, child: child);
  //     },
  //   );
  // }

  static Widget _getPage(String route) {
    final page = AppPages.routes.firstWhereOrNull((r) => r.name == route);
    if (page == null)
      throw UnimplementedError('Route $route is not defined in AppPages.');
    return page.page();
  }
}
