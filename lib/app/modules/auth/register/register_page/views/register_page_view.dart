import '../../../../../data/res/app.export.dart';

class RegisterPageView extends GetView<RegisterPageController> {
  const RegisterPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterPageController>(
      init: RegisterPageController(),
      builder: (controller) {
        return Obx(() => Stack(
          children: [
            AppScaffold(
              appBarTitle: "Register",
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.all(15),
                child: CustomButton(
                  onPressed: () {
                    if (controller.userKey.currentState!.validate()) {
                      controller.registerUser();
                    }
                  },
                  text: "Save",
                ),
              ),
              child: Form(
                key: controller.userKey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          enabled: true,
                          label: "Fast Name :",
                          controller: controller.fastNameController,
                          hintText: "Fast Name",
                          isSuffix: false,
                          validator: AppValidations.validateName,
                          keyboardType: TextInputType.text,
                        ),
                        2.ph,
                        CustomTextField(
                          enabled: true,
                          label: "Second Name:",
                          controller: controller.secondNameController,
                          hintText: "Second Name",
                          isSuffix: false,
                          validator: AppValidations.validateSecondName,
                          keyboardType: TextInputType.text,
                        ),
                        2.ph,
                        CustomTextField(
                          enabled: true,
                          label: "Email Id:",
                          controller: controller.emailIdController,
                          hintText: "Email Id",
                          isSuffix: false,
                          validator: AppValidations.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        2.ph,
                        CustomTextField(
                          enabled: true,
                          label: "Mobile Number:",
                          controller: controller.mobileNumberController,
                          hintText: "Mobile Number",
                          isSuffix: false,
                          validator: AppValidations.validateMobileNumber,
                          keyboardType: TextInputType.phone,
                        ),
                        2.ph,
                        CustomTextField(
                          enabled: true,
                          label: "Password",
                          controller: controller.passwordController,
                          hintText: "Password",
                          isSuffix: true,
                          validator: AppValidations.validatePassword,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black45,
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.appColor,),
                ),
              ),
          ],
        ));
      },
    );
  }
}

