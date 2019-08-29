import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {

  final String userId;
  final int id;
  final String title;
  final String body;

  Post({this.userId, this.id, this.title, this.body});

  factory Post.fromJSON(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"] as String,
      id: json["id"] as int,
      title: json["title"] as String,
      body: json["body"] as String,
    );
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map["userId"] = userId;
    //map["id"] = id;
    ///Not include in request passing parameter
    map["title"] = title;
    map["body"] = body;
    return map;
  }

  static Future<Post> createPost(String strURL, {Map body}) async {
    print("\n\ncreatePost\n\n");
    return http.post(strURL, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 400 || response == null) {
        throw Exception("Error while fetching data");
      }
      print("\n\n\n JSON Response = ${json.decode(response.body)} \n\n\n");
      return Post.fromJSON(json.decode(response.body));
    });
  }

}

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  static final CREATE_POST_URL = "https://jsonplaceholder.typicode.com/posts";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Post Request API Call"),
      ),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "Post Title", hintText: "title..."),
            ),
            TextField(
              controller: bodyController,
              decoration:
                  InputDecoration(labelText: "Body Text", hintText: "body..."),
            ),
            RaisedButton(
              child: Text("Create Post"),
              onPressed: () async {
                Post newPost = Post(
                    userId: "100001",
                    id: 10,
                    title: titleController.text,
                    body: bodyController.text);
                final Map<String, dynamic> mapBody = newPost.toMap();
                Post createdPost =
                    await Post.createPost(CREATE_POST_URL, body: mapBody);
                print(
                    "°°°°°°°\nCreated Title = ${createdPost.title} and Body = ${createdPost.body}");
              },
            ),
          ],
        ),
      ),
    );
  }
}

///Other Way API Call

class NetworkExampleScreen extends StatefulWidget {
  @override
  _NetworkExampleScreenState createState() => _NetworkExampleScreenState();
}

class _NetworkExampleScreenState extends State<NetworkExampleScreen> {

  final String url = "https://jsonplaceholder.typicode.com/photos/1";

  Future<Item> getItem() async {
    final response = await http.get(url);
    final responseJson = json.decode(response.body);
    return Item.fromJson(responseJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network Example")),
      body: Center(
        child: new Container(
          child: FutureBuilder<Item>(
            future: getItem(),
            builder: (BuildContext context, AsyncSnapshot<Item> snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.network(snapshot.data.image),
                            SizedBox(height: 16.0),
                            Text(snapshot.data.title),
                          ],
                        )
                      : InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
                            child: Text("ERROR OCCURRED, Tap to retry !"),
                          ),
                          onTap: () => setState(() {}))
                  : CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

}

class Item {
  final String title, image;

  Item(this.title, this.image);

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(json['title'], json['thumbnailUrl']);
  }
}
