import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  final size;

  ProfilePic({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.1,
      child: CircleAvatar(
        radius: 20.0,
        backgroundImage: NetworkImage(
            "https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940src"),
      ),
    );
  }
}
