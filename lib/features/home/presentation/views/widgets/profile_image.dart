import 'package:ahmed_karam/core/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 28,
      backgroundImage:
          userModel?.image == null
              ? AssetImage("assets/images/profile_image.jpeg")
              : CachedNetworkImageProvider(userModel!.image!),
    );
  }
}
