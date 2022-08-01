import 'package:flutter/material.dart';

class OptionalText extends StatelessWidget {
  const OptionalText({
    super.key,
    required this.context,
    required this.text,
  });
  final String? text;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Text(text!,
        style: Theme.of(context)
            .textTheme
            .titleMedium!
            .copyWith(color: Colors.grey));
  }
}
