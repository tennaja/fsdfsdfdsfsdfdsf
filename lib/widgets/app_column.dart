import 'package:flutter/material.dart';
import 'package:project_bekery/widgets/small_text.dart';
import 'big_text.dart';
import 'icon_and_text_widget.dart';

class AppColumn extends StatelessWidget {
  final String? text, sell, quantity, promotion;
  const AppColumn(
      {Key? key,
      required this.text,
      required this.sell,
      required this.quantity,
      required this.promotion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double star = int.parse(sell.toString()) / 10;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Bigtext(
            text: text.toString(), size: height / 32.46, color: Colors.black),
        SizedBox(
          height: height / 84.4,
        ),
        Row(
          children: [
            Wrap(
                children: List.generate(
                    star.round(),
                    (index) => Icon(
                          Icons.star,
                          color: Colors.redAccent,
                          size: 8,
                        ))),
            SizedBox(
              width: height / 42.2,
            ),
            Smalltext(text: "ขายได้"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "$sell"),
            SizedBox(
              width: 10,
            ),
            Smalltext(text: "ชิ้น"),
            Padding(
              padding: const EdgeInsets.only(left: 75),
              child: IconAndTextWidget(
                  icon: Icons.discount,
                  text: promotion == 'null' ? 'ไม่มีโปรโมชั่น' : "${promotion}",
                  iconColor: Color.fromARGB(255, 0, 255, 21)),
            ),
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
                text: "จำนวนเหลือในร้าน ${quantity} ชิ้น",
                iconColor: Colors.yellow.shade300),
            IconAndTextWidget(
                icon: Icons.access_alarm_rounded,
                text: "ใช้เวลาส่ง2-3วัน",
                iconColor: Colors.green.shade400)
          ],
        )
      ],
    );
  }
}
