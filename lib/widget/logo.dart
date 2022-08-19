import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String? image;
  final double? width;
  final double? height;

  const Logo({Key? key, required this.image, required this.width, required this.height}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Hero(
        tag: image.toString(),
        child: Image.network(image.toString(),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}