import 'dart:io';
import '../../../../../data/res/app.export.dart';

class RegisterPageController extends GetxController {
  final apiCall = ApiCall();
  final count = 0.obs;
  final userKey = GlobalKey<FormState>();
  final isLoading = false.obs;

  ///  loading flag

  TextEditingController fastNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  /// registerUser  api
  void registerUser() async {
    isLoading.value = true;

    /// Show loader
    /// body
    final formData = {
      "first_name": fastNameController.text.trim(),
      "last_name": secondNameController.text.trim(),
      "email_id": emailIdController.text.trim(),
      "mobile_no": mobileNumberController.text.trim(),
      "password": passwordController.text.trim(),
      "device_type": kIsWeb
          ? "web"
          : Platform.isAndroid
              ? "android"
              : Platform.isIOS
                  ? "ios"
                  : "unknown",
      "device_token": "${GlobalVar.fCMToken}",
    };

    /// api method
    await apiCall.fetchApiData(
      endPoint: ApiEndPoint.userCreate,
      method: MethodType.post,
      requestData: formData,
      successCallback: (response, message) {
        AppToast.toast(msg: message);
        isLoading.value = false;

        /// Hide loader
        NavigationService.goBack(result: true);
      },
      failureCallback: (message, statusCode) {
        AppToast.toast(msg: message);
        isLoading.value = false;

        /// Hide loader
      },
    );
  }
}
