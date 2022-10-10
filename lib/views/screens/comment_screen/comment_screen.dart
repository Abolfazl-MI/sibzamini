import 'package:flutter/material.dart';
import 'package:sibzamini/views/global/colors/solid_colors.dart';

class CommentScreen extends StatelessWidget{
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SolidColors.backGroundColor,

      body: Center(
        child: Text('commentScreen'),
      ),
    );
  }

}