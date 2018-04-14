import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dartdap/dartdap.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'LDAP LOGIN',
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: new LoginPage(title: 'LDAP LOGIN Home Page'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  Future example() async {

    // Create an LDAP connection object

    var host = "10.100.115.225";
    var ssl = false; // true = use LDAPS (i.e. LDAP over SSL/TLS)
    var port = null; // null = use standard LDAP/LDAPS port
    var bindDN  = ""; // null=unauthenticated
    var passwor = "";

    print(username);
    print(password);

    var connection = new LdapConnection(host: host);
    connection.setProtocol(ssl, port);
    connection.setAuthentication(bindDN, passwor);

    try {
      // Perform search operation

      var base = "ou=people,dc=iitb,dc=ac,dc=in";
      var filter = Filter.present("");
      var attrs = ["dc", "objectClass"];

      var count = 0;

      var searchResult = await connection.search(base, filter, attrs);
//      await for (var entry in searchResult.stream) {
//        // Processing stream of SearchEntry
//        count++;
//        print("dn: ${entry.dn}");
//
//        // Getting all attributes returned
//
//        for (var attr in entry.attributes.values) {
//          for (var value in attr.values) { // attr.values is a Set
//            print("  ${attr.name}: $value");
//          }
//        }
//
//        // Getting a particular attribute
//
//        assert(entry.attributes["dc"].values.length == 1);
//        var dc = entry.attributes["dc"].values.first;
//        print("# dc=$dc");
//      }
//
//      print("# Number of entries: ${count}");
    } catch (e) {
      print("Exception: $e");
    } finally {
      // Close the connection when finished with it
      await connection.close();
    }
  }

  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();

  String get username => _user.text;
  String get password => _pass.text;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(40.0),
              child: new Form(
                  child: new Column(
                children: <Widget>[
                  new TextField(
                    controller: _user,
                    decoration: new InputDecoration(
                      labelText: "Enter LDAP ID",
                      hintText: "LDAP ID",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                  new TextField(
                    controller: _pass,
                    decoration: new InputDecoration(
                      labelText: "Enter Password",
                      hintText: "Password",
                    ),
                    keyboardType: TextInputType.text,
                    obscureText: true,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                    ),
                    child: new MaterialButton(
                      color: Colors.blue,
                      textColor: Colors.white,
                      child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: new Text("Login")),
                      onPressed: example,
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
