import 'package:flutter/material.dart';
import 'package:flutter_app_expandtile_demo/CustomList.dart';
import 'package:flutter_app_expandtile_demo/gridView.dart';

void main() => runApp(CustomListTile());
//void main() => runApp(GridViewClass());
//void main() => runApp(ExpandTileDemo());

class ExpandTileDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Expandble Tiles"),
        ),

        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return EntryItem(data[index]);
          }
        ),
      ),
    );
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

class EntryItem extends StatelessWidget {

  EntryItem(this.entryItem);

  final Entry entryItem;

  Widget _buildTile(Entry entry) {
    if(entry.children.isEmpty) {
      return ListTile(
        title: Text(entry.title),
      );
    }

    return ExpansionTile(
      title: Text(entry.title),
      key: PageStorageKey<Entry>(entry),
      children: entry.children.map(_buildTile).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTile(entryItem);
  }

}


