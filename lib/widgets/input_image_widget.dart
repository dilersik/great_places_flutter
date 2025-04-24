import 'dart:io';

import 'package:flutter/material.dart';

class InputImageWidget extends StatefulWidget {
  final String imagePath;
  final Function(String) onImageSelected;

  const InputImageWidget({
    super.key,
    required this.imagePath,
    required this.onImageSelected,
  });

  @override
  InputImageWidgetState createState() => InputImageWidgetState();
}

class InputImageWidgetState extends State<InputImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Image'),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => widget.onImageSelected(widget.imagePath),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: widget.imagePath.isNotEmpty
                ? FileImage(File(widget.imagePath))
                : null,
            child: widget.imagePath.isEmpty
                ? const Icon(Icons.camera_alt, size: 60)
                : null,
          ),
        ),
      ],
    );
  }
}