import 'package:flutter/material.dart';

class UserCircularImage extends StatelessWidget {
  const UserCircularImage({
    Key? key,
    this.radius,
    this.imageURL,
  }) : super(key: key);

  final double? radius;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 55,
      backgroundImage: const AssetImage('assets/User.png'),
      foregroundImage: imageURL != '' ? NetworkImage(imageURL!) : null,
    );
  }
}

class BusinessCircularImage extends StatelessWidget {
  const BusinessCircularImage({
    Key? key,
    required this.radius,
    this.imageURL,
  }) : super(key: key);

  final double radius;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 55,
      backgroundImage: const AssetImage('assets/logo.png'),
      foregroundImage: imageURL != '' ? NetworkImage(imageURL!) : null,
    );
  }
}
