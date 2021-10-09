import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../../../constants.dart';

class ModalInsideModal extends StatelessWidget {
  bool reverse;
  String description = "";

  // const ModalInsideModal(String description, {Key? key, this.reverse = false}) : super(key: key);

  ModalInsideModal(this.reverse, this.description) {
    this.description = description;
    this.reverse = false;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          backgroundColor: kPrimaryColor,
          leading: Container(),
          middle: Text(
            'Details',
            style: TextStyle(color: Colors.white),
          )),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 50, left: 15, right: 15, top: 15),
            child: Html(data: description),
          ),
        ),
      ),
    ));
  }
}
