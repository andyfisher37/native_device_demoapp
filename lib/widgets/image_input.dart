import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  const ImageInput(this.onSelectImage, {super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  // Input image file - default "assets/images/no_photo.png"
  XFile? _storedImage;

  // Get local app path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Function for take photo from camera
  Future<void> _takePhoto() async {
    // Get camera image
    final XFile? imageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile == null) return;
    // Update state
    setState(() {
      _storedImage = imageFile;
    });
    // Save image to file
    final appPath = await _localPath;
    final fileName = Path.basename(imageFile.path);
    await imageFile.saveTo('$appPath/$fileName');
    widget.onSelectImage(imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            width: 150,
            height: 200,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            alignment: Alignment.center,
            child: _storedImage == null
                ? Image.asset('assets/images/no_photo.png')
                : Image.file(File(_storedImage!.path))),
        const SizedBox(width: 10),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takePhoto,
            icon: const Icon(Icons.camera),
            label: const Text('Take photo'),
          ),
        ),
      ],
    );
  }
}
