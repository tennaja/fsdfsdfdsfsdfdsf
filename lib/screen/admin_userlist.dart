import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import '../login/profire_model/customer_model.dart';
import '../mysql/service.dart';
import '../mysql/user.dart';

class DataTableDemo extends StatefulWidget {
  //
  DataTableDemo() : super();

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

// Now we will write a class that will help in searching.
// This is called a Debouncer class.
// I have made other videos explaining about the debouncer classes
// The link is provided in the description or tap the 'i' button on the right corner of the video.
// The Debouncer class helps to add a delay to the search
// that means when the class will wait for the user to stop for a defined time
// and then start searching
// So if the user is continuosly typing without any delay, it wont search
// This helps to keep the app more performant and if the search is directly hitting the server
// it keeps less hit on the server as well.
// Lets write the Debouncer class

class DataTableDemoState extends State<DataTableDemo> {
  List<User>? _user;
  // this list will hold the filtered employees
  List<User>? _filteruser;
  // controller for the First Name TextField we are going to create.
  TextEditingController? _firstNameController;
  // controller for the Last Name TextField we are going to create.
  TextEditingController? _lastNameController;
  User? _selectedUser;
  // This will wait for 500 milliseconds after the user has stopped typing.
  // This puts less pressure on the device while searching.
  // If the search is done on the server while typing, it keeps the
  // server hit down, thereby improving the performance and conserving
  // battery life...
  // Lets increase the time to wait and search to 2 seconds.
  // So now its searching after 2 seconds when the user stops typing...
  // That's how we can do filtering in Flutter DataTables.

  @override
  void initState() {
    super.initState();
    _user = []; // key to get the context to show a SnackBar
    _getUser();
  }

  _getUser() {
    print("function working");
    Services().getUsers().then((user) {
      print(
          "------------------------------------------------------------------------");
      setState(() {
        _user = user;

        _filteruser = user;
        // Initialize to the list from Server when reloading...
      }); // Reset the title...
      print("Length ${user.length}");
    });
  }

  // Method to clear TextField values

// Since the server is running locally you may not
// see the progress in the titlebar, its so fast...
// :)

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('เลขประจำตัว'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          // the list should show the filtered list now
          rows: _filteruser!
              .map(
                (user) => DataRow(cells: [
                  DataCell(
                    Text(user.user_id),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    onTap: () {},
                  ),
                  DataCell(
                    Text(
                      user.user_name,
                    ),
                    onTap: () {},
                  ),
                  DataCell(
                    Text(
                      user.user_phone,
                    ),
                    onTap: () {},
                  ),
                  DataCell(IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {},
                  ))
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  // Let's add a searchfield to search in the DataTable.

  // id is coming as String
  // So let's update the model...

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getUser();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
