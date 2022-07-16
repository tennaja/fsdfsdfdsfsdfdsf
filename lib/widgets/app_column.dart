import 'package:flutter/material.dart';
import 'package:project_bekery/widgets/small_text.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bigtext(text: text, size: height / 32.46, color: Colors.black),
        SizedBox(
          height: height / 84.4,
        ),
        Row(
          children: [
            Wrap(
                children: List.generate(
                    5,
                    (index) => Icon(
                          Icons.star,
                          color: Colors.redAccent,
                          size: 8,
                        ))),
            SizedBox(
              width: height / 42.2,
            ),
            Smalltext(text: "Rating"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "2.0"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "buyers"),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: Colors.yellow.shade300),
            IconAndTextWidget(
                icon: Icons.location_on,
                text: "1.7 km",
                iconColor: Colors.redAccent),
            IconAndTextWidget(
                icon: Icons.access_alarm_rounded,
                text: "3.2 min ",
                iconColor: Colors.green.shade400)
          ],
        )
      ],
    );
  }
}
