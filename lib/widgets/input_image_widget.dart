import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InputImageWidget extends StatefulWidget {
  final Function(File) onImageSelected;

  const InputImageWidget({super.key, required this.onImageSelected});

  @override
  InputImageWidgetState createState() => InputImageWidgetState();
}

class InputImageWidgetState extends State<InputImageWidget> {
  File? _storedImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Image'),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _takePicture(),
          child: CircleAvatar(
            radius: 140,
            backgroundImage: _storedImage != null ? FileImage(_storedImage!) : null,
            child: _storedImage == null ? const Icon(Icons.camera_alt, size: 60) : null,
          ),
        ),
      ],
    );
  }

  _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    ) as XFile;

    setState(() => _storedImage = File(imageFile.path));

    widget.onImageSelected(_storedImage!);
  }
}
