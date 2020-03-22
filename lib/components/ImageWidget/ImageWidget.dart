import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  ImageWidget({
    Key key,
    @required this.url,
    this.errorImagePath,
    this.width,
    this.height,
  }) : super(key: key);
  final String url;
  final double width;
  final double height;
  final String errorImagePath;

  @override
  Widget build(BuildContext context) {
    Widget defaultImage = Image(
      width: width,
      height: height,
      image: AssetImage(errorImagePath ?? 'images/noavatar_middle.png'),
    );

    CachedNetworkImage _image = CachedNetworkImage(
      width: width,
      height: height,
      imageUrl: url,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) {
        return defaultImage;
      },
    );
    return _image;
  }
}
