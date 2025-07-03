import '../../../../data/res/app.export.dart';

class LoginController extends GetxController {
  final apiCall = ApiCall();
  final count = 0.obs;
  final userKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  RxBool isPasswordVisible = false.obs;
  RxBool isLoading = false.obs;

  ///Add this

  void login() async {
    isLoading.value = true;

    ///Start loader

    final formData = {
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
    };

    await apiCall.fetchApiData(
      endPoint: ApiEndPoint.login,
      method: MethodType.post,
      requestData: formData,
      successCallback: (response, message) async {
        AppToast.toast(msg: message);
        final userData = response['data'];
        final userId = userData['id'].toString();

        await prefs.setString(LocalStorage.loginKey.toString(), "Register");
        await prefs.setString(LocalStorage.userId.toString(), userId);
        isLoading.value = false;

        /// Stop loader
        NavigationService.getToRoute(Routes.HOME_PAGE);
      },
      failureCallback: (message, statusCode) {
        AppToast.toast(msg: message);
        isLoading.value = false;

        /// Stop loader
      },
    );
  }
}
