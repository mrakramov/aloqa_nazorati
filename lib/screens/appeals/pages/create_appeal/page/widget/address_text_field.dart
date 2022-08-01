import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    super.key,
    required this.controller,
    required this.labelText,
  });
  final TextEditingController? controller;
  final String? labelText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        isDense: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: labelText!,
        border: const OutlineInputBorder(),
        suffixIcon: const Icon(
          Icons.expand_more_outlined,
          color: Colors.grey,
        ),
        prefix: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            icon: const SizedBox.shrink(),
            underline: const SizedBox.shrink(),
            items: const [
              DropdownMenuItem(child: Text('Andijon')),
            ],
            onChanged: (value) {}),
      ),
    );
  }
}
