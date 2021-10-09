import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:redlabeldistrict/components/custom_surfix_icon.dart';
import 'package:redlabeldistrict/components/default_button.dart';
import 'package:redlabeldistrict/constants.dart';

import '../../../size_config.dart';

class ModalInsideModal extends StatelessWidget {
  final bool reverse;

  const ModalInsideModal({Key? key, this.reverse = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          backgroundColor: kPrimaryColor,
          leading: Container(),
          middle: Text(
            'Add Voucher',
            style: TextStyle(color: Colors.white),
          )),
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(bottom: 50, left: 15, right: 15),
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                buildVoucherFormField(),
                SizedBox(
                  height: getProportionateScreenHeight(50),
                ),
                DefaultButton(
                  text: "Verify Voucher",
                  press: () {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  TextFormField buildVoucherFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      // onSaved: (newValue) => email = newValue!,
      // onChanged: (value) {
      //   if (value.isNotEmpty) {
      //     removeError(error: kEmailNullError);
      //   } else if (emailValidatorRegExp.hasMatch(value)) {
      //     removeError(error: kInvalidEmailError);
      //   }
      //   return null;
      // },
      // validator: (value) {
      //   if (value!.isEmpty) {
      //     addError(error: kEmailNullError);
      //     return "";
      //   } else if (!emailValidatorRegExp.hasMatch(value)) {
      //     addError(error: kInvalidEmailError);
      //     return "";
      //   }
      //   return null;
      // },
      decoration: InputDecoration(
        labelText: "Voucher",
        hintText: "Enter your Voucher Code",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }
}
