import 'package:flutter/material.dart';
import 'package:flutter_app_sqlite/utils/Database_Helper.dart';

List users;

void main() async{

  var db = new DatabaseHelper();
//  int savedUser = await db.saveUser(new User('jd','12'));
//  print('User Saved $savedUser');

  users = await db.getAllUser();
//  print(users);



//  User tempUser = await db.getUser(3);
//  print(tempUser.username);


//  int test = await db.getAllUserCount();
//
//  print(test);

//  for (int i = 0; i<users.length ; i++) {
//    User user = User.fromMap(users[i]);
//
//    print(db.getAllUserCount());
//
//    if (user.id == 1) {
//      db.deleteUser(user.id);
//    }
//
//    print(db.getAllUserCount());
//  }
//
//  print(users);
//  users = await db.getAllUser();
  print(users);


//  User editUser = User.fromMap({
//    'username': 'UpdateMMM',
//    'password': 'updatepass',
//    'id': 2
//  });

//  int edit = await db.updateUser(editUser);
//  print(edit);



  runApp(
      MaterialApp(
        home: new Home(),
      )
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        backgroundColor: Colors.lightGreen,
      ),
    );
  }
}


