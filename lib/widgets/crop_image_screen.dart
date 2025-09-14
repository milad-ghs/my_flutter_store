import 'dart:io';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

class CropImageScreen extends StatefulWidget {
  final String imagePath;
  const CropImageScreen({super.key,required this.imagePath});

  @override
  State<CropImageScreen> createState() => _CropImageScreenState();
}

class _CropImageScreenState extends State<CropImageScreen> {
  final _cropController = CropController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crop Image')),
      body: Crop(
        image: File(widget.imagePath).readAsBytesSync(),
        controller: _cropController,
        aspectRatio: 1,
        withCircleUi: true,
        onCropped: (croppedData){
          Navigator.of(context).pop(croppedData);
        },


      ),
    );
  }
}
