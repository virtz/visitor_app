import 'package:flutter/material.dart';
import 'package:visitor/utils/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

writeDataLocally({String key, String value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setString(key, value);
}
  getDataLocally({String key}) async {
          Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
          final SharedPreferences localData = await saveLocal;
          return localData.get(key);
        }
        



Widget appTextField(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    double sidePadding,
    TextInputType texttype,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  texttype == null ? texttype = TextInputType.text : texttype;

  return Padding(
    padding: EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword == null ? false : isPassword,
        keyboardType: texttype,
        decoration: InputDecoration(
            contentPadding: new EdgeInsets.all(13.0),
            border: InputBorder.none,
            hintText: textHint,
            suffixIcon: textIcon == null ? Column() : Icon(textIcon)),
      ),
    ),
  );
}

// Widget appButton(
//     {String buttonText,
//     double buttonPadding,
//     Color buttonColor,
//     Color textColor,
//     VoidCallback onClick}) {
//       buttonText == null ? buttonText == 'button':buttonText;
//       buttonPadding == null ? buttonPadding = 0.0 : buttonPadding;
//       buttonColor == null ? buttonColor = Colors.yellow:buttonColor;
//       textColor == null? textColor = Colors.black:textColor;

//    return   Padding(
//         padding:  EdgeInsets.all(buttonPadding),
//         child: Container(

//           child: RaisedButton(
//             onPressed: onClick,
//             color: buttonColor,
//               shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(15.0))),
//             child: Text(buttonText,style:TextStyle(color: textColor,fontSize: 15.0)),
//           ),
//         ),
//       );
//     }

displayProgressDialog(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (BuildContext context, _, __) {
        return ProgressDialog();
      }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

showSnackBar({BuildContext context, final key, String message}) {
  message == null ? message == " " : message;
  key.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.yellow,
    content: Text(message, style: TextStyle(color: Colors.black)),
  ));
}
