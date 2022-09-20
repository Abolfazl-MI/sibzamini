import 'package:flutter/material.dart';
import 'package:sibzamini/views/screens/home/slider_widgets/slider_widget.dart';

class SliderList extends StatelessWidget {
  const SliderList({Key? key}) : super(key: key);
// TODO: SHOULD GET LIST OF AVALABLE STH THEN USE 
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: 220,
      // color: Colors.amber,
      child: ListView.builder(
        itemCount: 20,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SliderWidget(title: 'سالن‌زیبایی‌ایمان', ratingCount: 2);
        },
      ),
    );
  }
}
