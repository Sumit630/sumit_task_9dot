import '../res/app.export.dart';

class JobDetailText extends StatelessWidget {
  final String label;
  final String value;

  const JobDetailText({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "$label: $value",
      style: inter.medium.get10.black,
    );
  }
}
