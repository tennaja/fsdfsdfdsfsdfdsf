import 'package:flutter/material.dart';
class TestPage extends StatefulWidget {
  const TestPage({ Key? key }) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: new Text('Search',style: TextStyle(
          color: Colors.white,
          fontSize: 20
        ),),
      backgroundColor: Colors.black,
      ),
      body: new ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: [
          new SizedBox(height: 20.0),
          new Container(
            child: new ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              physics: ScrollPhysics(),
              itemBuilder: (context, index) {
                return new Column(
                  children: <Widget>[
                    new Container(
                      height: 50.0,
                      color: Colors.black,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Padding(
                              padding: const EdgeInsets.only(right: 5.0)),
                          new Text('Romantic',
                              style: new TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                        ],
                      ),
                    ),
                    new Container(
                      height: 150.0,
                      child: new ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        itemBuilder: (context, index) {
                          return new Card(
                            elevation: 5.0,
                            child: new Container(
                              height: MediaQuery.of(context).size.width / 3,
                              width: MediaQuery.of(context).size.width / 3,
                              alignment: Alignment.topCenter,
                              child: Image(image: AssetImage('assets/image/kuncha.jpg'),
                              fit: BoxFit.cover,),
                            ),
                          );
                        },
                      ),
                    ),
                    new SizedBox(height: 10.0),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    ); 
  }
}