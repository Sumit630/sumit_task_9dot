
import 'package:sumittask9dot/app/data/res/app.export.dart';


class AppScaffold extends StatelessWidget {
  final String? appBarTitle;
  final List<Widget>? actions;

  final Widget child;
  final Widget? floatingButton;
  bool resizeToAvoidBottomInset;
  final Color? scaffoldBackgroundColor;
  final Widget? bottomNavigationBar;
  var result;

  AppScaffold({super.key,
    this.appBarTitle,
    this.floatingButton,
    required this.child,
    this.actions,
    this.resizeToAvoidBottomInset = true,
    this.scaffoldBackgroundColor,
    this.bottomNavigationBar,
    this. result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:resizeToAvoidBottomInset,
      appBar: appBarTitle != null
          ? AppBar(
        title:Text(appBarTitle ?? "", style:inter.bold.get14.white),
        elevation: 0.0,
        backgroundColor: AppColors.appColor,
        leading: BackWidget(result: result,),
        actions: actions,
        centerTitle: false,
      )
          : null,
      floatingActionButton: floatingButton,
      backgroundColor: scaffoldBackgroundColor,
      body: child,
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}