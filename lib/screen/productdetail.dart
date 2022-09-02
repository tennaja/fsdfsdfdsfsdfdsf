import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_bekery/screen/quantity.dart';
import 'package:project_bekery/screen/user_order.dart';
import 'package:project_bekery/screen/user_welcome.dart';
import '../widgets/app_column.dart';
import '../widgets/app_icon.dart';
import '../widgets/big_text.dart';
import '../widgets/colors.dart';
import '../widgets/exandable_text_widget.dart';

class productdetail extends StatefulWidget {
  final String string;
  productdetail(this.string, {Key? key}) : super(key: key);
  @override
  State<productdetail> createState() => _productdetailState();
}

class _productdetailState extends State<productdetail> {
  @override
  Widget build(BuildContext context) {
    int quantity = 1;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    CollectionReference users =
        FirebaseFirestore.instance.collection('product');
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.string).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          int quantity_val = 1;
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
            body: Container(
              color: Colors.orangeAccent.withOpacity(0.5),
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.maxFinite,
                        height: height / 2.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(data['product_image']))),
                      )),
                  Positioned(
                      top: height / 18.76,
                      left: height / 42.2,
                      right: height / 42.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Orderpage();
                                }));
                              },
                              child: AppIcon(icon: Icons.arrow_back_ios)),
                          GestureDetector(
                              onTap: () {},
                              child:
                                  AppIcon(icon: Icons.shopping_cart_outlined))
                        ],
                      )),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: height / 2.4 - 30,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: height / 42.2,
                          right: height / 42.2,
                          top: height / 42.2,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(height / 42.2),
                                topLeft: Radius.circular(height / 42.2)),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppColumn(
                              text: "${data['product_name']}",
                              quantity: '',
                              sell: '',
                              promotion: '',
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Bigtext(
                              text: "แนะนำ",
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: height / 42.2,
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                child: ExpandableTextWidget(
                                    text:
                                        "ตราฉัตร หนึ่งในแบรนด์ข้าวชั้นนำของไทย เปิดประสบการณ์ซื้อข้าวให้สนุกยิ่งขึ้น ผ่านเลือกซื้อข้าวที่ใช่ตาม Lifestyle พร้อมเปิด Fresh Rice หน้าร้านแบบ Pop-up Store ที่มีเครื่องสีข้าวคุณภาพสูงกลางห้าง ตราฉัตร ได้เปิดตัว Fresh Rice หน้าร้านรูปแบบ Pop-up Store ภายใต้แนวคิด Personalize & Premium Niche ที่นำเอาพันธุ์ข้าวใหม่ๆ และพันธุ์ดั้งเดิมหลากหลายชนิด คัดสายพันธุ์อย่างดีจากแหล่งเพาะปลูกที่มีคุณภาพ ตรวจสอบย้อนกลับได้ทุกขั้นตอนการผลิต ข้าวจะถูกบรรจุอยู่ในหลอดให้ลูกค้าสามารถเลือกเองได้ นอกจากนี้ยังมีบริการขัดสีข้าวกันสดๆ ผ่านเครื่องขัดสีคุณภาพชั้นนำที่นำเข้าจากประเทศญี่ปุ่น สามารถสีข้าวสดได้ครั้งละ 500 กรัม/เครื่อง โดยนำข้าวกล้องหอมมะลิตราฉัตร ที่เก็บรักษาความสดใหม่ไว้ด้วยอุณหภูมิ 15 องศาเซลเซียส มาขัดสีสด จนได้ข้าว Germ Rice (ข้าวที่มีจมูกข้าว) ทำให้คงคุณประโยชน์ไว้ได้มากที่สุด สำหรับข้าวที่จำหน่ายจะมี 4 สายพันธุ์คือ ข้าวหอมมะลิ Single Origin คุณภาพดี ราคาขายที่ 49 บาท/กก. ข้าวขาว (White Rice) คุณภาพชั้นเยี่ยม ราคาขายที่ 25 บาท/กก. ข้าวกข 43 (RD43) พันธุ์ใหม่ ราคาขายที่ 35 บาท/กก. และ ข้าวกล้องหอมมะลิ (Muti Vitamin) ราคาขายที่ 45 บาท/กก. ขณะเดียวกันที่ Fresh Rice ยังมีผู้เชี่ยวชาญด้านข้าว Rice Specialist ที่จะคอยให้ความรู้ แนะนำข้าวแต่ละชนิดให้เหมาะสมกับไลฟ์สไตล์ของผู้บริโภค สำหรับลูกค้าที่นำภาชนะมาใส่ข้าวเอง รับแต้มสมาชิกโลตัส แทนคำขอบคุณที่ช่วยกันลดปัญหาสิ่งแวดล้อม โดยเบื้องต้น Fresh Rice ตั้งอยู่ที่โลตัสสาขาเลียบทางด่วน เอกมัย-รามอินทรา"),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              height: height / 5.0,
              padding: EdgeInsets.only(
                  top: height / 28.13,
                  bottom: height / 28.13,
                  left: height / 42.2,
                  right: height / 42.2),
              decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(height / 42.2 * 2),
                      topRight: Radius.circular(height / 42.2 * 2))),
              child: product_quantity(widget.string),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('รายระเอียดสินค้า'),
          ),
        );
      },
    );
  }
}
