import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visitor/models/user.dart';
import 'package:visitor/models/visitor.dart';
import 'package:visitor/services/api.dart';
import 'package:visitor/ui/signin.dart';
import 'dart:convert';

class Users extends StatefulWidget {
  final String id;

  const Users({Key key, this.id}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool b = false;
  var users = List<User>();
    var visitors = List<Visitor>();
    int index;

  var key;
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<User>(
        future: _getVisitors(),
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              return Container(
                height: (MediaQuery.of(context).size.height / 10),
                child: Card(
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      //   Navigator.push(context,
                      //       MaterialPageRoute(builder: (context) => Post()));
                      // },
                    },
                    child: GestureDetector(
                      onTap: () {
                      //  _alertDialogue(context," You're requesting to see ${users[index].name} ?","Request");
                      },
                      child: InkWell(
                        child: ListTile(
                            leading: Text(
                              users[index].name,
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w600),
                            ),
                            // leading: Row(
                            //   children: <Widget>[
                            //     Text(users[index].status)
                            //   ],
                            // ),
                            trailing: Text(users[index].status)),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        key:key,
        tooltip: 'Tap to sign out',
        child: Icon(FontAwesomeIcons.signOutAlt),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          _alertDialogue1(context, "You're siging out of this app", "Sign Out ");
        },
      ),
    );
  }

  initState() {
    super.initState();
_getVisitors();
getRequestStats();
  }

  dispose() {
    super.dispose();
  }

  _getVisitors() {
    Api.getUsers().then((response) {
    if(this.mounted){
        setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
       
      });
    }
    });
  }
  signOut()async{
   bool a =  await Api.signOut().whenComplete((){
     
    });
     print(a);
     if(a == true){
       Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>SignIn()));
     }
  }
      _alertDialogue(BuildContext context,String message,String header){
  showDialog(
  context: context,
  builder:(BuildContext context){
    return AlertDialog(
      title:Text(header),
      content: Text(message),
      actions: <Widget>[
       
         RaisedButton(
            child:Text("Ok"),
            onPressed: (){
              setState(() {
               b= true; 
              });
              Navigator.of(context).pop(true);
            },
        )
      ],
    );
  }
);
}
      _alertDialogue1(BuildContext context,String message,String header){
  showDialog(
  context: context,
  builder:(BuildContext context){
    return AlertDialog(
      title:Text(header),
      content: Text(message),
      actions: <Widget>[
        RaisedButton(
            child:Text("Cancel"),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
         Container(
           width: 80,
           child: RaisedButton(
              child:Text("Continue"),
              onPressed: (){
                Navigator.of(context).pop(true);
                signOut();
              },
        ),
         )
      ],
    );
  }
);
}

getRequestStats(){
Timer(Duration(minutes: 2),()async{

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String vId =prefs.getString('id');

      Api.getVisitor().then((response) { 
   if(this.mounted){
        setState(() {
        Iterable list = json.decode(response.body);
        visitors = list
            .map((model) => Visitor.fromJson(model))
            .where((i)=> i.id.compareTo(vId)==0 && i.status !="Neutral" && i.who == widget.id)         
            .toList();
             print(widget.id);
             print(vId);
           
             print(visitors.length);
             for( var v in visitors){
                  _alertDialogue(context, "Your request was ${v.status}","Request Status");
               
             }
             
        return visitors;
      });
   }
    });
  

});

}
}
