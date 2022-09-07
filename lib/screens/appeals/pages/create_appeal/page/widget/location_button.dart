import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';

class LocationButton extends StatelessWidget {
  const LocationButton({
    super.key,
    required Size? size,
    required this.callBack,
    required this.text,
  }) : _size = size;

  final Size? _size;
  final VoidCallback? callBack;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _size!.width * 0.18),
      height: 60,
      width: double.infinity,
      child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
              primary: ColorsUtils.buttonColor,
              side: const BorderSide(color: ColorsUtils.myColor),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: callBack,
          icon: Image.asset(
            'assets/icons/map_location.png',
            color: ColorsUtils.buttonColor,
            width: 30,
          ),
          label: Text(
            text!,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ColorsUtils.buttonColor,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          )),
    );
  }
}
