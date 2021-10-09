import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_svg/svg.dart';
import 'package:redlabeldistrict/components/custom_surfix_icon.dart';
import 'package:redlabeldistrict/components/default_button.dart';
import 'package:redlabeldistrict/constants.dart';
import 'package:redlabeldistrict/models/Cart.dart';
import 'package:redlabeldistrict/models/Order.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Checkout extends StatefulWidget {
  final bool reverse;

  Checkout({Key? key, this.reverse = false}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int checker = 1;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  //Form fields
  String email = "";
  String fname = "";
  String lname = "";
  String address = "";
  String country = "";
  String state = "";
  String city = "";
  String zip = "";
  String number = "";

  final Email = TextEditingController();
  final Fname = TextEditingController();
  final Lname = TextEditingController();
  final Address = TextEditingController();
  final Country = TextEditingController();
  final State = TextEditingController();
  final City = TextEditingController();
  final Zip = TextEditingController();
  final Number = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final PageController _pageController = PageController();

  final List<String> errors = [];

  void addError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  void makePayment() {}

  void createOrder() {
    email = Email.text;
    fname = Fname.text;
    lname = Lname.text;
    address = Address.text;
    country = Country.text;
    state = State.text;
    city = City.text;
    zip = Zip.text;
    number = Number.text;

    for (int i = 0; i < demoCarts.length; i++) {
      ListItems.add(Order(
          productId: demoCarts[i].product.id,
          numOfItem: demoCarts[i].numOfItem));
    }

    FormData formData = FormData.fromMap({
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "set_paid": true,
      "billing": {
        "first_name": fname,
        "last_name": lname,
        "address_1": address,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": zip,
        "country": country,
        "email": email,
        "phone": number
      },
      "shipping": {
        "first_name": fname,
        "last_name": lname,
        "address_1": address,
        "address_2": "",
        "city": city,
        "state": state,
        "postcode": zip,
        "country": country
      },
      "line_items": ListItems,
      "shipping_lines": [
        {
          "method_id": "flat_rate",
          "method_title": "Flat Rate",
          "total": "10.00"
        }
      ]
    });

    print(formData);
    print("List Data");
    print(ListItems);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          backgroundColor: kPrimaryColor,
          leading: Container(),
          middle: Text(
            'Checkout',
            style: TextStyle(color: Colors.white),
          )),
      child: SafeArea(
        bottom: false,
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HeadingText("Personal Details"),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildFnameFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildLnameFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildEmailFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildPnumberFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    DefaultButton(
                      text: "Next",
                      press: () {
                        FocusScope.of(context).unfocus();
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            1,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HeadingText("Shipping Details"),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildAddressFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildCityFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildStateFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildCountryFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildZipFormField(),
                    SizedBox(
                      height: getProportionateScreenHeight(40),
                    ),
                    DefaultButton(
                      text: "Next",
                      press: () {
                        FocusScope.of(context).unfocus();
                        if (_pageController.hasClients) {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HeadingText("Bank Details"),
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      cardBgColor: kPrimaryLightColor,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            cardNumberDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                            ),
                            expiryDateDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                            themeColor: kPrimaryColor,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    DefaultButton(
                      text: "Next",
                      press: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          if (_pageController.hasClients) {
                            _pageController.animateToPage(
                              3,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        } else {
                          print('invalid!');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HeadingText("Order Summary"),
                    Container(
                      height: getProportionateScreenHeight(200),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(20)),
                          child: Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                              itemCount: demoCarts.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Dismissible(
                                  key: Key(
                                      demoCarts[index].product.id.toString()),
                                  direction: DismissDirection.endToStart,
                                  onDismissed: (direction) {
                                    setState(() {
                                      demoCarts.removeAt(index);
                                    });
                                  },
                                  background: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFFE6E6),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      children: [
                                        Spacer(),
                                        SvgPicture.asset(
                                            "assets/icons/Trash.svg"),
                                      ],
                                    ),
                                  ),
                                  child: CartCard(cart: demoCarts[index]),
                                ),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: kTextColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Personal Details",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(fname + " " + lname),
                        Text(number),
                        Text(email),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: kTextColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Shipping Details",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(address),
                        Text(country),
                        Text(zip),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: kTextColor,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Payment Details",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(cardNumber),
                        Text(cardHolderName),
                        Text(expiryDate),
                        Text(cvvCode),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    DefaultButton(
                      text: "Confirm Order",
                      press: () {
                        createOrder();
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  TextFormField buildFnameFormField() {
    return TextFormField(
      controller: Fname,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          fname = newValue!;
          print("first name" + fname);
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kfNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kfNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildLnameFormField() {
    return TextFormField(
      controller: Lname,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          lname = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: klNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: klNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your Last Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: Email,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          email = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your Email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildPnumberFormField() {
    return TextFormField(
      controller: Number,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          number = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your Phone Number",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      controller: Address,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          address = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your Address",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildCountryFormField() {
    return TextFormField(
      controller: Country,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          country = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCountrylNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCountrylNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Country",
        hintText: "Enter your Country",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildStateFormField() {
    return TextFormField(
      controller: State,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          state = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kStatelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kStatelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "State",
        hintText: "Enter your State",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildCityFormField() {
    return TextFormField(
      controller: City,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          city = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCitylNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kCitylNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "City",
        hintText: "Enter your City",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  TextFormField buildZipFormField() {
    return TextFormField(
      controller: Zip,
      keyboardType: TextInputType.text,
      onSaved: (newValue) {
        setState(() {
          zip = newValue!;
        });
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kZiplNullError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kZiplNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Zip",
        hintText: "Enter your Zip",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/receipt.svg"),
      ),
    );
  }

  Widget HeadingText(String data) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Text(
        '$data',
        style: TextStyle(
            color: kTextColor,
            fontSize: 24,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
