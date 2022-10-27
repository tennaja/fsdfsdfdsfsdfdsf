import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_bekery/drawer/Constants/Constants.dart';
import 'package:project_bekery/drawer/Models/CDM.dart';
import 'package:project_bekery/drawer/Widgets/Widgets.dart';
import 'package:project_bekery/login/login.dart';
import 'package:project_bekery/screen/addproducttype.dart';
import 'package:project_bekery/screen/addpromotion.dart';
import 'package:project_bekery/screen/addsource.dart';
import 'package:project_bekery/screen/admin_addproduct_promotion.dart';
import 'package:project_bekery/screen/admin_import_order.dart';
import 'package:project_bekery/screen/admin_import_product.dart';
import 'package:project_bekery/screen/admin_orderall.dart';
import 'package:project_bekery/screen/admin_ordercancellist.dart';
import 'package:project_bekery/screen/admin_orderlist.dart';
import 'package:project_bekery/screen/admin_orderpackgelist.dart';
import 'package:project_bekery/screen/admin_productall.dart';
import 'package:project_bekery/screen/admin_report_order.dart';
import 'package:project_bekery/screen/admin_userlist.dart';
import 'package:project_bekery/screen/adminaddrider.dart';
import 'package:project_bekery/screen/float_add_order.dart';

class ComplexDrawerPage extends StatefulWidget {
  const ComplexDrawerPage({Key? key}) : super(key: key);

  @override
  _ComplexDrawerPageState createState() => _ComplexDrawerPageState();
}

class _ComplexDrawerPageState extends State<ComplexDrawerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
      drawer: ComplexDrawer(),
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  AppBar appBar() {
    return AppBar(
      iconTheme: IconTheme.of(context).copyWith(
        color: Colorz.complexDrawerBlack,
      ),
      title: Txt(
        text: "Complex Drawer",
        color: Colorz.complexDrawerBlack,
      ),
      backgroundColor: Colorz.compexDrawerCanvasColor,
    );
  }

  Widget body() {
    return Center(
      child: Container(
        foregroundDecoration: BoxDecoration(
          color: Colorz.complexDrawerBlack,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: FlutterLogo(
          size: 150,
        ),
      ),
    );
  }
}

class ComplexDrawer extends StatefulWidget {
  const ComplexDrawer({Key? key}) : super(key: key);

  @override
  _ComplexDrawerState createState() => _ComplexDrawerState();
}

class _ComplexDrawerState extends State<ComplexDrawer> {
  int selectedIndex = -1; //dont set it to 0

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return row();
  }

  Widget row() {
    return blackIconTiles();
  }

  Widget blackIconTiles() {
    return Container(
      width: 200,
      color: Colorz.complexDrawerBlack,
      child: Column(
        children: [
          controlTile(),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  Container(
                    color: Color(0xFF231942),
                    child: ExpansionTile(
                      leading: Icon(Icons.shopping_basket, color: Colors.white),
                      title: Txt(
                        text: 'ออเดอร์',
                        color: Colors.white,
                      ),
                      children: [
                        Container(
                          color: Color(0xFF231942),
                          child: ListTile(
                            leading: Icon(Icons.shopping_basket,
                                color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_orderlist();
                              }));
                            },
                            title: Text(
                              'หน้ารับออเดอร์',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF231942),
                          child: ListTile(
                            leading: Icon(Icons.shopping_basket,
                                color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_orderpackgelist();
                              }));
                            },
                            title: Text(
                              'หน้ายืนยันการแพ็คของ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF231942),
                          child: ListTile(
                            leading: Icon(Icons.shopping_basket,
                                color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_ordercancellist();
                              }));
                            },
                            title: Text(
                              'หน้าต่างรอการยกเลิก',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFF5e548e),
                    child: ExpansionTile(
                      leading: Icon(Icons.settings, color: Colors.white),
                      title: Txt(
                        text: 'แก้ไขข้อมูล',
                        color: Colors.white,
                      ),
                      children: [
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return adminaddrider();
                              }));
                            },
                            title: Text(
                              'เพิ่มข้อมูลพนักงาน',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return addsource();
                              }));
                            },
                            title: Text(
                              'เพิ่มแหล่งที่มาของสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_addproductpromotion();
                              }));
                            },
                            title: Text(
                              'เพิ่มโปรโมชั่นให้สินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return add_product_order();
                              }));
                            },
                            title: Text(
                              'เพิ่มสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return addpromotion();
                              }));
                            },
                            title: Text(
                              'เพิ่มโปรโมชั่น',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF5e548e),
                          child: ListTile(
                            leading: Icon(Icons.add, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return addproducttype();
                              }));
                            },
                            title: Text(
                              'เพิ่มประเภทสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFF9f86c0),
                    child: ExpansionTile(
                      leading: Icon(Icons.import_export, color: Colors.white),
                      title: Txt(
                        text: 'นำเข้า',
                        color: Colors.white,
                      ),
                      children: [
                        Container(
                          color: Color(0xFF9f86c0),
                          child: ListTile(
                            leading:
                                Icon(Icons.import_export, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_import_source();
                              }));
                            },
                            title: Text(
                              'นำเข้าสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF9f86c0),
                          child: ListTile(
                            leading:
                                Icon(Icons.import_export, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return adminhistoryimport();
                              }));
                            },
                            title: Text(
                              'ประวัติการนำเข้าสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFF9f86c0),
                          child: ListTile(
                            leading:
                                Icon(Icons.import_export, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_import_order();
                              }));
                            },
                            title: Text(
                              'รายงานนำเข้าสินค้า',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFbe95c4),
                    child: ExpansionTile(
                      leading: Icon(Icons.list, color: Colors.white),
                      title: Txt(
                        text: 'รายงาน',
                        color: Colors.white,
                      ),
                      children: [
                        Container(
                          color: Color(0xFFbe95c4),
                          child: ListTile(
                            leading: Icon(Icons.list, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_orderall();
                              }));
                            },
                            title: Text(
                              'รายงานการขาย',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFFbe95c4),
                          child: ListTile(
                            leading: Icon(Icons.list, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_report();
                              }));
                            },
                            title: Text(
                              'รายงานยอดการขาย',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          color: Color(0xFFbe95c4),
                          child: ListTile(
                            leading: Icon(Icons.list, color: Colors.white),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return admin_allproduct();
                              }));
                            },
                            title: Text(
                              'รายงานสินค้าในคลัง',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xFFe0b1cb),
                    child: ListTile(
                      leading: Icon(Icons.person, color: Colors.white),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return admin_Userlist();
                        }));
                      },
                      title: Text(
                        'รายชื่อผู้ใช้',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    color: Color(0xFFe8b4bc),
                    child: ListTile(
                      leading: Icon(Icons.logout_outlined, color: Colors.white),
                      onTap: () {
                        showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('ออกจากระบบ'),
                                content:
                                    const Text('ต้องการที่จะออกจากระบบไหม?'),
                                actions: <Widget>[
                                  ElevatedButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("ไม่"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushAndRemoveUntil(
                                        CupertinoPageRoute(
                                            builder: (context) => LoginPage()),
                                        (_) => false,
                                      );
                                    },
                                    child: const Text("ใช่"),
                                  ),
                                ],
                              );
                            });
                      },
                      title: Text(
                        'ออกจากระบบ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          accountTile(),
        ],
      ),
    );
  }

  Widget controlTile() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 5),
      child: ListTile(
        leading: Image(image: AssetImage('assets/images/app_logo.png')),
        title: Txt(
          text: "AungPao",
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onTap: expandOrShrinkDrawer,
      ),
    );
  }

/*
  Widget blackIconMenu() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: 100,
      color: Colorz.complexDrawerBlack,
      child: Column(
        children: [
          controlButton(),
          Expanded(
            child: ListView.builder(
                itemCount: cdms.length,
                itemBuilder: (contex, index) {
                  // if(index==0) return controlButton();
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      height: 45,
                      alignment: Alignment.center,
                      child: Icon(cdms[index].icon, color: Colors.white),
                    ),
                  );
                }),
          ),
          accountButton(),
        ],
      ),
    );
  }
*/
/*
  Widget invisibleSubMenus() {
    // List<CDM> _cmds = cdms..removeAt(0);
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: isExpanded ? 0 : 125,
      color: Colorz.compexDrawerCanvasColor,
      child: Column(
        children: [
          Container(height: 95),
          Expanded(
            child: ListView(
                itemCount: cdms.length,
                itemBuilder: (context, index) {
                  CDM cmd = cdms[index];
                  // if(index==0) return Container(height:95);
                  //controll button has 45 h + 20 top + 30 bottom = 95

                  bool selected = selectedIndex == index;
                  bool isValidSubMenu = selected && cmd.submenus.isNotEmpty;
                  return subMenuWidget(
                      [cmd.title]..addAll(cmd.submenus), isValidSubMenu);
                }),
          ),
        ],
      ),
    );
  }
*/
  Widget controlButton() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 30),
      child: InkWell(
        onTap: expandOrShrinkDrawer,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          child: FlutterLogo(
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget subMenuWidget(List<String> submenus, bool isValidSubMenu) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isValidSubMenu ? submenus.length.toDouble() * 37.5 : 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isValidSubMenu
              ? Colorz.complexDrawerBlueGrey
              : Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          )),
      child: ListView.builder(
          padding: EdgeInsets.all(6),
          itemCount: isValidSubMenu ? submenus.length : 0,
          itemBuilder: (context, index) {
            String subMenu = submenus[index];
            return sMenuButton(subMenu, index == 0);
          }),
    );
  }

  Widget sMenuButton(String subMenu, bool isTitle) {
    return InkWell(
      onTap: () {
        //handle the function
        //if index==0? donothing: doyourlogic here
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Txt(
          text: subMenu,
          fontSize: isTitle ? 17 : 14,
          color: isTitle ? Colors.white : Colors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget accountButton({bool usePadding = true}) {
    return Padding(
      padding: EdgeInsets.all(usePadding ? 8 : 0),
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        height: 45,
        width: 45,
        decoration: BoxDecoration(
          color: Colors.white70,
          image: DecorationImage(
            image: NetworkImage(Urls.avatar2),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  Widget accountTile() {
    return Container(
      color: Colorz.complexDrawerBlueGrey,
      child: ListTile(
        leading: Icon(
          Icons.admin_panel_settings,
          color: Colors.white,
        ),
        title: Txt(
          text: "Ten Wachirawit",
          color: Colors.white,
        ),
        subtitle: Txt(
          text: "Admin",
          color: Colors.white70,
        ),
      ),
    );
  }

/*
  static List<CDM> cdms = [
    // CDM(Icons.grid_view, "Control", []),

    CDM(Icons.grid_view, "Dashboard", []),
    CDM(Icons.subscriptions, "Category",
        ["HTML & CSS", "Javascript", "PHP & MySQL"]),
    CDM(Icons.markunread_mailbox, "Posts", ["Add", "Edit", "Delete"]),
    CDM(Icons.pie_chart, "Analytics", []),
    CDM(Icons.trending_up, "Chart", []),
    CDM(Icons.power, "Plugins",
        ["Ad Blocker", "Everything Https", "Dark Mode"]),
    CDM(Icons.explore, "Explore", []),
    CDM(Icons.settings, "Setting", []),
  ];
*/
  void expandOrShrinkDrawer() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
