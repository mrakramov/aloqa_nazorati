import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required Size? size,
    required this.context,
    required this.text,
    required this.isLoading,
    required this.callback,
  }) : _size = size;

  final Size? _size;
  final bool? isLoading;
  final BuildContext context;
  final String? text;
  final VoidCallback? callback;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      width: _size!.width,
      child: ElevatedButton(
        onPressed: !isLoading! ? callback : null,
        style: ElevatedButton.styleFrom(
            primary: ColorsUtils.myColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))),
        child: isLoading!
            ? const CircularProgressIndicator()
            : Text(
                text!,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
