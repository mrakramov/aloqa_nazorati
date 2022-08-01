import 'package:aloqa_nazorati/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FileAddButtonAndCamera extends StatelessWidget {
  const FileAddButtonAndCamera({
    super.key,
    required this.context,
    required this.callBackForFile,
    required this.callBackForCamera,
    required this.text,
  });

  final BuildContext context;
  final VoidCallback callBackForFile;
  final VoidCallback callBackForCamera;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          child: SizedBox(
            height: 60,
            child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                    foregroundColor: ColorsUtils.myColor,
                    side: const BorderSide(color: ColorsUtils.myColor),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: callBackForFile,
                icon: const FaIcon(Icons.add),
                label: Text(
                  text,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: ColorsUtils.myColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                )),
          ),
        ),
        IconButton(
            onPressed: callBackForCamera,
            icon: const Icon(
              Icons.camera,
              color: ColorsUtils.myColor,
            )),
      ],
    );
  }
}
