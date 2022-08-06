import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    required Size? size,
    required this.keyForm,
    required this.controller,
    required this.text,
  }) : _size = size;

  final Size? _size;
  final GlobalKey<FormState> keyForm;
  final TextEditingController? controller;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        height: _size!.height * 0.3,
        width: _size!.width,
        child: Form(
          key: keyForm,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 10,
            decoration: InputDecoration(
                hintText: text!,
                hintStyle: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey),
                isCollapsed: false,
                filled: false,
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}
