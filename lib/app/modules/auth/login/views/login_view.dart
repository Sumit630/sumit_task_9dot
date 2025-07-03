import '../../../../data/res/app.export.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (controller) {
        return Obx(() => Stack(
              children: [
                Scaffold(
                  backgroundColor: Colors.white,
                  body: BackgroundScreen(
                    child: Form(
                      key: controller.userKey,
                      child: Column(
                        children: [
                          1.ph,
                          Center(
                              child: Lottie.asset(AppLottie.loginLottie,
                                  height: H.h30(context))),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 24),
                                padding:
                                    const EdgeInsets.all(defaultPadding * 2),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    1.ph,
                                    Text(
                                      'Login',
                                      textAlign: TextAlign.center,
                                      style: inter.bold.get16.black,
                                    ),
                                    4.ph,
                                    CustomTextField(
                                      enabled: true,
                                      label: "Email :",
                                      controller: controller.emailController,
                                      hintText: "Email",
                                      isSuffix: false,
                                      validator: AppValidations.validateEmail,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    2.ph,
                                    CustomTextField(
                                      controller: controller.passwordController,
                                      enabled: true,
                                      label: "Password :",
                                      hintText: "Password",
                                      isSuffix: true,
                                      validator:
                                          AppValidations.validatePassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                    ),
                                    4.ph,
                                    CustomButton(
                                      text: "Login",
                                      onPressed: () {
                                        if (controller.userKey.currentState!
                                            .validate()) {
                                          controller.login();
                                        }
                                      },
                                    ),
                                    2.ph,
                                    const Divider(thickness: 1),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text("Don't have an account?"),
                                        TextButton(
                                          onPressed: () {
                                            NavigationService.getToRoute(
                                                Routes.REGISTER_PAGE);
                                          },
                                          child: Text(
                                            'Register',
                                            style: inter.bold.get14.copyWith(
                                                color: AppColors.appColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (controller.isLoading.value)
                  Container(
                    color: Colors.black26,
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.appColor,
                      ),
                    ),
                  ),
              ],
            ));
      },
    );
  }
}
