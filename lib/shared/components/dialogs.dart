import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showMessage(String title, String message, BuildContext context) async {
  if (Platform.isAndroid) {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctxt) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  if (Platform.isIOS) {
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext ctxt) {
        return CupertinoAlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

showSnackBar(BuildContext context, String _text, {Color backgroundColor = Colors.blueAccent, int milliseconds = 3000}) {
  try {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        shape: StadiumBorder(),
        duration: Duration(milliseconds: milliseconds),
        backgroundColor: backgroundColor,
        content: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            _text,
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  } catch (e) {
    print(e.toString());
  }
}

Future<bool> inputQuestion(BuildContext context, String _titulo, String _corpo,
    [Function _functionConfirmar = null, String labelConfirmar = 'CONFIRMAR', String labelCancelar = 'CANCELAR']) async {
  bool confirmSelect = false;

//Botões
  Widget _btnConfirmar = FlatButton(
    child: Text(
      labelConfirmar,
      style: TextStyle(color: Colors.green, fontSize: 18),
    ),
    onPressed: () {
      confirmSelect = true;

      if (_functionConfirmar != null) _functionConfirmar();

      Navigator.of(context).pop();
    },
  );

  Widget _btnCancelar = FlatButton(
    child: Text(
      labelCancelar,
      style: TextStyle(color: Colors.redAccent, fontSize: 18),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
// AlertDialog
  AlertDialog alert = AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: new BorderRadius.circular(10.0),
    ),
    title: Text(
      _titulo,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
    ),
    content: Text(_corpo),
    actions: [
      _btnConfirmar,
      _btnCancelar,
    ],
  );
// Exibindo
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );

  return confirmSelect;
}

Future<bool> inputQuestionThrow(BuildContext context, String _titulo, String _corpo,
    [Function _functionConfirmar = null, String labelConfirmar = 'CONFIRMAR', String labelCancelar = 'CANCELAR']) async {
  if (!(await inputQuestion(context, _titulo, _corpo, _functionConfirmar, labelConfirmar, labelCancelar))) throw 'inputQuestion-Cancelar';
}
