import 'package:sumittask9dot/app/data/res/app.export.dart';

class BackWidget extends StatelessWidget {
  final Function()? onPressed;
  final Color? iconColor;
  var result;

  BackWidget({super.key, this.onPressed, this.iconColor, this.result});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed ??
          () {
            NavigationService.goBack(result: result);
          },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.white,
      ),
    );
  }
}
