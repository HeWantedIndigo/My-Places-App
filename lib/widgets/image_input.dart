import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspath;

class ImageInput extends StatefulWidget {

  final Function selectFunction;

  ImageInput(this.selectFunction);
  
  @override
  _ImageInputState createState() => _ImageInputState();

}


class _ImageInputState extends State<ImageInput> {

  File _storedImage;

  Future _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (imageFile == null)
      return;
    setState(() {
      _storedImage = imageFile;
    });
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);  //To get the file name and extension
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    widget.selectFunction(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).primaryColor,
            )
          ),
          child: _storedImage == null ?
            Text("No Image") :
            Image.file(
              _storedImage,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          alignment: Alignment.center,
        ),
        OutlineButton.icon(
          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
          color: Colors.white,
          icon: Icon(Icons.camera_alt),
          label: Text("Take picture"),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        ),
      ],
    );

  }
}