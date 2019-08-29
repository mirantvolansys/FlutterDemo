import 'package:flutter/material.dart';

class SimpleListCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple List Cell"),
      ),
      body: listView(context),
    );
  }
}

Widget listView(BuildContext context) {
  return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
          /*leading: Icon(
              Icons.label_important
          ),*/
          title: Text(
            "${index+1} Row Title",
          ),
          subtitle: Text(
            "orem Ipsum is simply dummy text of the printing and typesetting industry. "
                "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                "when an unknown printer took a galley of type and scrambled it to make a type specimen book. "
                "It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. "
                "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, "
                "and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          ),
          trailing: Icon(Icons.navigate_next),
          onTap: () {
            print("°°°°°°°°°°°°°°°°°ON TAP AT INDEX $index°°°°°°°°°°°°°°°°°°°°°°°°°");
          },
        );
      },
      separatorBuilder: (context, index) {
         return Divider(
           height: 1.0,
         );
      },
  );
}
