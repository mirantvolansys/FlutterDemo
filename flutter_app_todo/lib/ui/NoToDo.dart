import 'package:flutter/material.dart';
import 'package:flutter_app_todo/models/nodo_item.dart';
import 'package:flutter_app_todo/utils/Database_Helper.dart';
import 'package:flutter_app_todo/utils/date_formatter.dart';

class NoToDo extends StatefulWidget {
  @override
  _NoToDoState createState() => _NoToDoState();
}

class _NoToDoState extends State<NoToDo> {
  TextEditingController _textEditingController = TextEditingController();

  var db = DatabaseHelper();

  final List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();

    _readTodoList();
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();

    NoDoItem _item = new NoDoItem(text, dateFormatted());
    int resultSave = await db.saveItem(_item);

    NoDoItem addedItem = await db.getItem(resultSave);

    setState(() {
      _itemList.add(addedItem);
    });

    print(resultSave);

    Navigator.pop(context);
  }

  void _handleUpdate(int index, NoDoItem item) async {
    _textEditingController.clear();

    setState(() {
//      _itemList.clear();

      _itemList.removeWhere((element) {
        _itemList[index].itemName == item.itemName;
      });
    });

    await db.updateItem(item);

    setState(() {
      _readTodoList();
    });

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              reverse: false,
              padding: EdgeInsets.all(8.0),
              itemCount: _itemList.length,
              itemBuilder: (_ , int index){
                return Card(
                  color: Colors.white10,
                  child: new ListTile(
                    title: _itemList[index],
                    onLongPress: () => _updateItem(_itemList[index], index),
                    trailing: new Listener(
                      key: new Key(_itemList[index].itemName),
                      child: new Icon(Icons.remove_circle,
                      color: Colors.redAccent,),
                      onPointerDown: (pointerEvent) => 
                      _deleteItem(_itemList[index].id, index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: _showFromDialog,
      ),
    );
  }

  void _showFromDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
              child: TextField(
            controller: _textEditingController,
            autofocus: true,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: 'Item',
                hintText: "eg. Don't buy stuff",
                icon: Icon(Icons.note_add)),
          ))
        ],
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              _handleSubmit(_textEditingController.text);
            },
            child: Text('Save')),
        FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel')),
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  void _readTodoList() async {
    var items = await db.getItems();

    items.forEach((item) {
      NoDoItem noDoItem = NoDoItem.formMap(item);

      setState(() {
        _itemList.add(noDoItem);
      });
      print('DB Items ${noDoItem.itemName}');
    });
  }

  _deleteItem(int id, int index) async{
    print("Deleted");

    await db.deleteItem(id);

      setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(NoDoItem item, int index) {
    var alert = new AlertDialog(
      title: new Text("Update Item"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              decoration: new InputDecoration(
                hintText: "eg. Don't buy stuff",
                labelText: "Item",
                icon: new Icon(Icons.update),
              ),

              autofocus: true,
              controller: _textEditingController,
            ),
          ),
        ],
      ),

      actions: <Widget>[
        new FlatButton(onPressed: () async {
          NoDoItem newItemUpdated = NoDoItem.formMap({
            "itemName" : _textEditingController.text,
            "dateCreated" : dateFormatted(),
            "id" : item.id,
          });

          _handleUpdate(index, newItemUpdated);
        },

            child: Text('Update')),

        new FlatButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
      ],
    );

    showDialog(context: context,
    builder: (_){
      return alert;
    });
  }
}
