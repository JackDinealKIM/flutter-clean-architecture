import 'package:clean_architecture/model/pixabay_photo.dart';
import 'package:flutter/material.dart';

class PhotoWidget extends StatelessWidget {

  final PixabayPhoto photo;

  const PhotoWidget({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.0)),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(photo.previewUrl),
        ),
      ),
    );
  }
}
