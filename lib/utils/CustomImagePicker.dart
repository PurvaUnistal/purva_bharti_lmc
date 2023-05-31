import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CustomImagePicker extends StatefulWidget {
  String buttonTitle;
  ImageSource imageSource;
  PhotoController photoController;
  Function(String path) onPath;

  CustomImagePicker(this.buttonTitle, this.imageSource, {this.photoController, this.onPath});

  @override
  State<StatefulWidget> createState() {
    return new CustomImagePickerState();
  }
}

class CustomImagePickerState extends State<CustomImagePicker> {
  File _image;
  PhotoController controller;
  String _placeHolder = 'assets/images/place_holder.png';

  CustomImagePickerState({this.controller});
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final picker = ImagePicker();
    // final pickedFile = await picker.getImage(source:imageSource);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
            child: Text(
              widget.buttonTitle,
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              _openImageSource(context, controller);
              /*final pickedFile =
                  await picker.getImage(source: widget.imageSource,maxHeight:400,maxWidth:300,imageQuality: 100);

              setState(() {
                if (pickedFile != null) {
                  _image=File(pickedFile.path);
                  if (widget.photoController != null)
                    widget.photoController.imagePath = File(pickedFile.path);
                  if (widget.onPath != null)
                    widget.onPath(pickedFile.path);
                } else {
                  print('No image selected.');
                }
              });*/
            }),
        _image != null
            ? Container(
                child: Row(
                children: [
                  Image.file(
                    _image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ), /*Text('${_getImageName(widget.photoController.imagePath.uri.toString())}')*/
                ],
              ))
            : Container(
                child: Row(
                children: [
                  Image.asset(
                    _placeHolder,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ), /*Text('${_getImageName(widget.photoController.imagePath.uri.toString())}')*/
                ],
              ))
      ],
    );
  }

  Future<void> _openImageSource(
    BuildContext mContext,
    PhotoController controller,
  ) async {
    final picker = ImagePicker();
    return showDialog<void>(
      context: mContext,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose One'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                    title: Text('Gallery'),
                    onTap: () async {
                      Navigator.of(context).pop();
                      final pickedFile = await picker.getImage(source: ImageSource.gallery, maxHeight: 900, maxWidth: 1000, imageQuality: 100);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                          if (widget.photoController != null) widget.photoController.imagePath = File(pickedFile.path);
                          if (widget.onPath != null) widget.onPath(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    }),
                ListTile(
                  title: Text('Camera'),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final pickedFile = await picker.getImage(source: ImageSource.camera, maxHeight: 900, maxWidth: 1000, imageQuality: 100);

                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                        if (widget.photoController != null) widget.photoController.imagePath = File(pickedFile.path);
                        if (widget.onPath != null) widget.onPath(pickedFile.path);
                      } else {
                        print('No image selected.');
                      }
                    });
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getImageName(String filename) {
    String _path1 = filename;
    List<String> _sList = _path1.split('/'); // ['P', 'u', 'b']
    int length = _sList.length;
    String fileName1 = '${_sList[length - 1]}';
    _path1 = _path1.replaceAll(fileName1, '');
    print(_path1);
    print(fileName1);

    return fileName1;
  }
}

class PhotoController {
  File imagePath;
}
