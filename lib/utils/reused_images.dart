import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ReusedImages extends StatelessWidget {
  final Function onTap,onPressed1,onPressed2;
  final String imageText;

  const ReusedImages({Key key, this.onTap, this.onPressed1, this.onPressed2,this.imageText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File _profileImage;
    String profileImagePath = '';
    return  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(imageText),
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 10),
            child: _profileImage == null ? profileImagePath.isEmpty ? Container(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                child: DottedBorder(
                  padding: const EdgeInsets.all(20),
                  borderType: BorderType.Circle,
                  dashPattern: const [6, 3],
                  color: Colors.grey,
                  child: Image.asset('assets/icons/place_holder.png'),
                ),
                onTap:  onTap,
              ),
            ) : Container(
              alignment: Alignment.topLeft,
              child: Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(profileImagePath),
                  backgroundColor: Colors.black.withOpacity(0.7),
                  child: IconButton(icon: Icon(Icons.delete_outlined,
                    color: Colors.white.withOpacity(0.7),),
                      onPressed: onPressed1),
                ),
              ),
            )
                : Container(
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: FileImage(_profileImage),
                    radius: 40,
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.7),
                        child: IconButton(icon: Icon(Icons.delete_outlined,
                          color: Colors.white.withOpacity(0.7),),
                            onPressed: onPressed2),
                      ),
                    ),
                  )
                ],
              ),
            )
        ),
      ],
    );
  }
}
