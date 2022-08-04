import 'package:flutter/material.dart';

class LatWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  const LatWidget({
    super.key,
    required this.addressController,
    required this.hintText,
    required this.labelText,
  });

  final TextEditingController? addressController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextField(
        enabled: false,
        controller: addressController,
        decoration: InputDecoration(
            // hintText: 'Manzilni kiriting',
            labelText: hintText!,
            hintText: labelText!,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder()),
      ),
    );
  }
}
