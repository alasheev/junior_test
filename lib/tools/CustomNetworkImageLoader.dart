import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junior_test/tools/MyColors.dart';

class CustomNetworkImageLoader extends StatelessWidget {
  String url = "";
  Widget placeHolder;
  bool isColorFiltered = true;

  CustomNetworkImageLoader(this.url, this.placeHolder, this.isColorFiltered);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: url,
        imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                color: MyColors.black_light,
                image: DecorationImage(
                    colorFilter: isColorFiltered
                        ? ColorFilter.mode(
                            MyColors.black.withOpacity(0.6), BlendMode.darken)
                        : null,
                    image: imageProvider,
                    fit: BoxFit.cover)),
            child: placeHolder),
        errorWidget: (context, url, error) => Container(
              color: MyColors.grey,
              child: placeHolder,
            ));
  }
}
