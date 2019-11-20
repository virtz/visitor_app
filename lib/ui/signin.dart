import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:visitor/models/visitor.dart';
import 'package:visitor/services/api.dart';
import 'package:visitor/ui/users.dart';
import 'package:visitor/utils/tools.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController who = TextEditingController();
  Visitor visitor;

  var data = [];
String mySelection;
 

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
   getData();
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage('assets/2.jpg'))),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: height * 0.20),
                Container(
                  //color: Colors.yellow,
                  height: height * 0.15,

                  child: Center(
                      child: Text(
                    "Sign In",
                    style: TextStyle(
                        color: Colors.yellowAccent,
                        fontSize: 30,
                        fontStyle: FontStyle.italic),
                  )),
                  // )),
                ),
                SizedBox(height: height / 40),
                appTextField(
                  isPassword: false,
                  sidePadding: 12.0,
                  textHint: 'Name',
                  textIcon: Icons.person,
                  controller: name,
                ),
                SizedBox(height: height / 56.2),
                appTextField(
                  isPassword: false,
                  sidePadding: 12.0,
                  textHint: 'Address',
                  textIcon: Icons.home,
                  controller: address,
                ),
                SizedBox(height: height / 56.2),
                appTextField(
                    isPassword: false,
                    sidePadding: 12.0,
                    textHint: 'Phone',
                    textIcon: Icons.phone,
                    controller: phone,
                    texttype: TextInputType.number),
                SizedBox(height: height / 56.2),
                appTextField(
                  isPassword: false,
                  sidePadding: 12.0,
                  textHint: 'Purpose',
                  textIcon: Icons.publish,
                  controller: purpose,
                ),
                // SizedBox(height: height / 56.2),
                // appTextField(
                //   isPassword: false,
                //   sidePadding: 12.0,
                //   textHint: 'Who',
                //   textIcon: Icons.person_pin,
                //   controller: who,
                // ),

                SizedBox(height: height / 56.2),
             Padding(
               padding: const EdgeInsets.only(left:8.0,right:8.0),
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(12.0),
                   color: Colors.white
                 ),
                //  color: Colors.white,
                 width:width - 30,
        child: DropdownButtonHideUnderline(
                  child: new DropdownButton(
                  
            items: data.map((item) {
              return new DropdownMenuItem(
                  child: Center(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: new Text(item['name']),
                  )),
                  value: item['_id'],
                  
              );
            }).toList(),
            hint:Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Select'),
            ),
            onChanged: (newVal) {
              setState(() {
                  mySelection = newVal;
                  print(mySelection);
              });
            },
            value: mySelection,
          ),
        ),
      ),
             ),
    

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    //  width: width,

                    height: 50.0,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        __signIn();
                      },
                      child: Text('Sign in'),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                ),
                Container(height: 300)
              ],
            ),
          ),
        ));
  }

  initState() {
    super.initState();
    this.getData();
      }
    
      clearTextFields() {
        name.text = "";
        address.text = "";
        phone.text = "";
        purpose.text = "";
        who.text = "";
      }
    
      __signIn() async {
        if (name.text == "" || name.text.length <= 5) {
          showSnackBar(
              message: 'Please enter your name or name is too short',
              key: scaffoldKey);
          return;
        }
        if (address.text == "" || address.text.length <= 5) {
          showSnackBar(
              message: 'Please enter your address or address is too short',
              key: scaffoldKey);
          return;
        }
        if (phone.text == "") {
          showSnackBar(message: 'Please enter your phone', key: scaffoldKey);
          return;
        }
        if (purpose.text == "") {
          showSnackBar(message: 'Please enter your purpose', key: scaffoldKey);
          return;
        }
        if (mySelection == "") {
          showSnackBar(
              message: "We need to know who you're here to see", key: scaffoldKey);
          return;
        }
    
        displayProgressDialog(context);
    
        bool success = await Api.signIn(
                name.text, address.text, phone.text, purpose.text, mySelection)
            .whenComplete(() {});
        clearTextFields();
        closeProgressDialog(context);
        if (success = true && success != null) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => Users(
                id: mySelection,
              )),
              (Route route) => route == null);
        } else {
          showSnackBar(message: "Sorry An Error Occured", key: scaffoldKey);
        }
      }
    
       getData() {
         var resBody ;
        Api.getUsers().then((response){
          resBody = json.decode(response.body);
          setState(() {
           data = resBody; 
          });
        });
        return resBody;
      }
}
