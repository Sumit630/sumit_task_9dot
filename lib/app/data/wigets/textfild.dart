import 'package:flutter/cupertino.dart';
import '../res/app.export.dart';

Widget TextFieldTitle({required String text}) {
  return Text(
    text,
    style: inter.bold.get9.black,
  );
}

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final int? maxLength;
  final double? maxHeight, radius;
  final TextStyle? style, hintStyle;
  final TextAlign? textAlign;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final String? hintText;
  final String? label;
  final Color? fillColor;
  final Widget? prefix;
  final bool? enabled;

  final Widget? suffix;

  final bool? isSuffix,
      showCursor,
      enableInteractiveSelection,
      readOnly,
      isRequired;
  final String? Function(String?)? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    this.focusNode,
    this.textInputAction,
    this.hintText,
    this.textAlign,
    this.textCapitalization,
    this.prefix,
    this.suffix,
    this.fillColor,
    this.radius,
    this.hintStyle,
    this.inputFormatters,
    this.isRequired = false,
    this.keyboardType,
    this.maxHeight,
    this.maxLines,
    this.maxLength,
    this.onChanged,
    this.onTap,
    this.label,
    this.style,
    this.readOnly,
    this.isSuffix,
    this.showCursor,
    this.enableInteractiveSelection,
    this.validator,
    this.enabled,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isShowPass = false;
  bool isValue = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    isShowPass = widget.isSuffix ?? false;
    isValue = widget.controller.text.isNotEmpty;
    widget.controller.addListener(_updateValue);
  }

  void _updateValue() {
    setState(() {
      isValue = widget.controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateValue);
    super.dispose();
  }

  void _unfocus() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _unfocus, // Dismiss keyboard when tapping outside
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            Row(
              children: [
                TextFieldTitle(
                  text: widget.label ?? "",
                ),
                if (widget.isRequired == true)
                  TextFieldTitle(
                    text: "*",
                  ),
              ],
            ),
            const SizedBox(height: 5),
          ],
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.radius ?? 10),
              //  border: Border.all(color: Colors.grey.withOpacity(.50), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                TextFormField(
                  enabled: widget.enabled,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  keyboardType: widget.keyboardType ?? TextInputType.text,
                  textCapitalization:
                      widget.textCapitalization ?? TextCapitalization.none,
                  inputFormatters: widget.inputFormatters ?? [],
                  textInputAction:
                      widget.textInputAction ?? TextInputAction.next,
                  maxLines: widget.maxLines ?? 1,
                  cursorColor: AppColors.appColor,
                  style: widget.style ?? inter.bold.get9.black,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  obscureText: isShowPass,
                  obscuringCharacter: '•',
                  showCursor: widget.showCursor,
                  cursorOpacityAnimates: true,
                  enableInteractiveSelection:
                      widget.enableInteractiveSelection ?? true,
                  readOnly: widget.readOnly ?? false,
                  onTap: widget.onTap,
                  onTapOutside: (event) {
                    _unfocus(); // Unfocus when tapping outside
                    widget.onTap?.call();
                  },
                  onChanged: (val) {
                    setState(() {
                      errorMessage = widget.validator?.call(val);
                    });
                    widget.onChanged?.call(val);
                  },
                  validator: (value) {
                    final message = widget.validator?.call(value);
                    setState(() {
                      errorMessage = message;
                    });
                    return message;
                  },
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                      borderSide: BorderSide(
                        color: Colors.grey
                            .withOpacity(.50), // default green border
                        width: 1.5,
                      ),
                    ),
                    errorStyle:
                        const TextStyle(fontSize: 0, color: Colors.transparent),
                    prefixIcon: widget.prefix,
                    suffixIcon: widget.suffix,
                    hintText: widget.hintText ?? "",
                    hintStyle: widget.hintStyle ??
                        inter.bold.get9.copyWith(color: AppColors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                      borderSide: BorderSide(
                        color: AppColors
                            .appColorWithOpacity, // your custom focus color
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: widget.fillColor ?? Colors.transparent,
                  ),
                ),
                widget.isSuffix == true && isValue == true
                    ? IconBtnWidget(
                        onPressed: () {
                          setState(() {
                            isShowPass = !isShowPass;
                          });
                        },
                        icon: Icon(
                            isShowPass == false
                                ? CupertinoIcons.eye_fill
                                : CupertinoIcons.eye_slash_fill,
                            size: 18),
                      )
                    : const Gap(),
              ],
            ),
          ),
          if (errorMessage != null && errorMessage!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: Text(errorMessage ?? "",
                  style: inter.bold.get9.black.copyWith(color: AppColors.red)),
            )
        ],
      ),
    );
  }
}
