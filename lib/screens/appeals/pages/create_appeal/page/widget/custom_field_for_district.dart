import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomFieldForRegions extends StatelessWidget {
  final Widget? prefix;
  final String? hintText;
  const CustomFieldForRegions(
      {super.key, required this.prefix, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        decoration: InputDecoration(
            isDense: true,
            filled: false,
            enabled: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: hintText,
            // hintText: hintText,
            hintStyle: const TextStyle(color: ColorsUtils.myColor),
            focusColor: ColorsUtils.myColor,
            floatingLabelStyle: const TextStyle(color: ColorsUtils.myColor),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
              color: ColorsUtils.myColor,
            )),
            border: const OutlineInputBorder(
                borderSide: BorderSide(
              color: ColorsUtils.myColor,
            )),
            // contentPadding: EdgeInsets.zero,
            suffixIcon: const Icon(
              Icons.expand_more_outlined,
              color: Colors.grey,
            ),
            prefixStyle: const TextStyle(color: ColorsUtils.myColor),
            prefix: prefix),
      ),
    );
  }
}
