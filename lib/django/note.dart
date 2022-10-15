import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? name, username, avatar;
  bool isData = false;

  FetchJSON() async {
    var Response = await http.get(
      Uri.parse("https://mugumbya.herokuapp.com/notes/2/"),
    //  headers: {"Accept": "application/json"},
    );

    if (Response.statusCode == 200) {
      String responseBody = Response.body;
      var responseJSON = json.decode(responseBody);
      username = responseJSON['body']??'cow';
      name = responseJSON['id'].toString();
      avatar = responseJSON['avatar_url'];
      isData = true;
      setState(() {
        print('UI Updated');
      });
    } else {
      print('Something went wrong. \nResponse Code : ${Response.statusCode}');
    }
  }

  @override
  void initState() {
    FetchJSON();
  }

  Widget MyUI() {
    return new Container(
      padding: new EdgeInsets.all(20.0),
      child: new ListView(
        children: <Widget>[
          new Image.network(
            'https://avatars.githubusercontent.com/u/15886737?v=4',
            width: 100.0,
            height: 100.0,
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
          new Text(
            'Name : $name',
            style: TextStyle(fontSize: 20),
          ),
          new Padding(padding: new EdgeInsets.symmetric(vertical: 6.0)),
          new Text(
            'Username : ${username??'no data'}',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Fetch JSON'),
        ),
        body: MyUI()
      ),
    );
  }
}