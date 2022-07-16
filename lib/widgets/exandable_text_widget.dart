import 'package:flutter/material.dart';
import 'package:project_bekery/widgets/colors.dart';
import 'package:project_bekery/widgets/small_text.dart';

class ExpandableTextWidget extends StatefulWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandableTextWidget> createState() => _ExpandableTextWidgetState();
}

class _ExpandableTextWidgetState extends State<ExpandableTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double textHeight = height / 5.63;
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    return Container(
      child: secondHalf.isEmpty
          ? Smalltext(
              color: Colors.black, size: height / 52.75, text: firstHalf)
          : Column(
              children: [
                Smalltext(
                    height: 1.8,
                    color: Colors.black,
                    size: height / 52.75,
                    text: hiddenText
                        ? (firstHalf + "...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      Smalltext(
                        text: "เพิ่มเติม",
                        color: AppColors.MainColor,
                      ),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down_outlined
                            : Icons.arrow_drop_up,
                        color: AppColors.MainColor,
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
