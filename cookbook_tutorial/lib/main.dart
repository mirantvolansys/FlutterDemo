import 'alert_dialog.dart';
import 'grid_list.dart';
import 'horizontal_list.dart';
import 'package:flutter/material.dart';
import 'simple_list_cell.dart';
import 'list_with_image.dart';
import 'custom_scrollview_list.dart';
import 'swipe_tab_with_card.dart';
import 'bottom_navigation_tab.dart';
import 'drawer_screen_redirection.dart';
import 'form_validation.dart';
import 'simple_fetch_apicall.dart';
import 'create_post_apicall.dart';
import 'multipart_formdata_apicall.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tutorial Demo",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Builder(builder: (context) => Container(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[

              CustomRaisedButton(
                  title: "Alert Dialog",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AlertDialogDemo()));
                  }
              ),

              CustomRaisedButton(
                  title: "Grid List",
                  onPressed: () {
                    _navigateBackToScreenDisplay(context);
                  }
              ),

              CustomRaisedButton(
                  title: "Horizontal List",
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => HorizontalList()));
                  }
              ),

              CustomRaisedButton(
                title: "Simple Cell List",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SimpleListCell()));
                },
              ),

              CustomRaisedButton(
                title: "List with Image",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ListWithImage())
                  );
                },
              ),

              CustomRaisedButton(
                title: "Custom ScrollView List",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CustomScrollViewList()));
                },
              ),

              CustomRaisedButton(
                title: "Swipe Tab With Card",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SwipeTabCard()));
                },
              ),

              CustomRaisedButton(
                title: "Bottom Navigation Tab",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => BottomNavigationTab()));
                },
              ),

              CustomRaisedButton(
                title: "Drawer Screen Redirection",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DrawerScreenRedirection()));
                },
              ),

              CustomRaisedButton(
                title: "Form Design with Validation",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => FormValidation()));
                },
              ),

              CustomRaisedButton(
                title: "Simple Fetch Data From API",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SimpleFetchData()));
                },
              ),

              CustomRaisedButton(
                title: "Simple Post Request API",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => CreatePost()));//NetworkExampleScreen()
                },
              ),

              CustomRaisedButton(
                title: "Upload Image",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => UploadImageData()));//NetworkExampleScreen()
                },
              ),

            ],
          )
        )
      ),
      backgroundColor: Colors.grey,
    );
  }

  _navigateBackToScreenDisplay(BuildContext context) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => GridList()));
    Scaffold.of(context).removeCurrentSnackBar();
    Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("$result"),
          duration: Duration(seconds: 1),
        )
    );
  }

}

class CustomRaisedButton extends StatelessWidget {

  final String title;
  final GestureTapCallback onPressed;

  CustomRaisedButton({@required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPressed,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Icon(Icons.navigate_next),
        ],
      ),
    );
  }

}

