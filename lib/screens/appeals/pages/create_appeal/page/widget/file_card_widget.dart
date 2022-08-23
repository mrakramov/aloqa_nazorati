import 'package:flutter/material.dart';

class FileCardWidget extends StatelessWidget {
  final VoidCallback onDelete;
  final String? name;
  const FileCardWidget({
    super.key,
    required this.onDelete,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 0.9,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xFFE4E4E4),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Text(
                  name!,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Expanded(
                  flex: 4,
                  child: GestureDetector(
                    onTap: onDelete,
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.red,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
