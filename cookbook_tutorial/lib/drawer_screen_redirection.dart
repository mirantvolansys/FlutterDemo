import 'package:flutter/material.dart';

class DrawerScreenRedirection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Drawer Home"),
          leading: Builder(builder: (BuildContext context) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              //mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                        }
                        )
                ),
                Expanded(
                    child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    }
                  )
                ),
              ],
            );
          })),
      body: Center(
        child: Text("Drawer Home Page"),
      ),
      drawer: DrawerItem(),
    );
  }

}

class DrawerItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    _onListTileTap(BuildContext context) {
      Navigator.of(context).pop();
      showDialog<Null>(
        context: context,
        child: new AlertDialog(
          title: const Text('Not Implemented'),
          actions: <Widget>[
            new FlatButton(
              child: const Text('OK'),
              onPressed: () {
                //Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Dhaval Sabhaya"),
            accountEmail: Text("dhaval.sabhaya@volansys.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("DS"),
            ),
            onDetailsPressed: () {
              Navigator.pop(context);
              // Navigator.of(context).pushNamed(Notes.routeName) won't have
              // transition animation and can be used for modal forms
              // Which we will see in Forms & Validation.
              // Navigator.of(context).pushNamed(Notes.routeName);

              // To add transition we are using PageRouteBuilder
              Navigator.of(context).pushReplacement(
                  new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return new DrawerScreenRedirection();
                      },
                      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation,
                            child: child
                        );
                      }
                  )
              );
            },
          ),
          new ListTile(
            leading: new Icon(Icons.lightbulb_outline),
            title: new Text('Notes'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.of(context).pushNamed(Notes.routeName) won't have
              // transition animation and can be used for modal forms
              // Which we will see in Forms & Validation.
              // Navigator.of(context).pushNamed(Notes.routeName);

              // To add transition we are using PageRouteBuilder
              Navigator.of(context).pushReplacement(
                  new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return new NotesMenu();
                      },
                      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation,
                            child: child
                        );
                      }
                  )
              );
            },
          ),
          new Divider(),
          new ListTile(
            leading: new Text('Label'),
            trailing: new Text('Edit'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.label),
            title: new Text('Expense'),
            onTap: () {
              Navigator.pop(context);
              // Navigator.of(context).pushNamed(Notes.routeName) won't have
              // transition animation and can be used for modal forms
              // Which we will see in Forms & Validation.
              // Navigator.of(context).pushNamed(Notes.routeName);

              // To add transition we are using PageRouteBuilder
              Navigator.of(context).pushReplacement(
                  new PageRouteBuilder(
                      pageBuilder: (BuildContext context, _, __) {
                        return new ExpenseMenu();
                      },
                      transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
                        return new FadeTransition(
                            opacity: animation,
                            child: child
                        );
                      }
                  )
              );
            },
          ),
          new ListTile(
            leading: new Icon(Icons.label),
            title: new Text('Inspiration'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.label),
            title: new Text('Personal'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.label),
            title: new Text('Work'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.add),
            title: new Text('Create new label'),
            onTap: () => _onListTileTap(context),
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.archive),
            title: new Text('Archive'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.delete),
            title: new Text('Trash'),
            onTap: () => _onListTileTap(context),
          ),
          new Divider(),
          new ListTile(
            leading: new Icon(Icons.settings),
            title: new Text('Settings'),
            onTap: () => _onListTileTap(context),
          ),
          new ListTile(
            leading: new Icon(Icons.help),
            title: new Text('Help & feedback'),
            onTap: () => _onListTileTap(context),
          )
        ],
      ),
    );

  }
}


class NotesMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerItem(),
      appBar: AppBar(
        title: Text("Notes"),
      ),
      body: Center(
        child: Text(
          "Manage your notes.",
          style: TextStyle(
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}


class ExpenseMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerItem(),
      appBar: AppBar(
        title: Text("Expense"),
      ),
      body: Center(
        child: Text(
          "Manage your expenses.",
          style: TextStyle(
            color: Colors.deepPurple,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 25.0,
          ),
        ),
      ),
    );
  }
}


