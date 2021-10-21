import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:redlabeldistrict/components/custom_surfix_icon.dart';
import 'package:redlabeldistrict/components/default_button.dart';
import 'package:redlabeldistrict/components/form_error.dart';
import 'package:redlabeldistrict/constants.dart';
import 'package:redlabeldistrict/helper/keyboard.dart';
import 'package:redlabeldistrict/models/Cart.dart';
import 'package:redlabeldistrict/models/Order.dart';
import 'package:redlabeldistrict/models/OrderHistory.dart';
import 'package:redlabeldistrict/network/network_calls.dart';

import '../../../size_config.dart';
import 'cart_card.dart';

class Checkout extends StatefulWidget {
  final bool reverse;

  Checkout({Key? key, this.reverse = false}) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final ScrollController _controllerOne = ScrollController();

  int checker = 1;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  double total = 0;
  bool isLoading = false;

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

  orderCreate() {
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
          product_id: demoCarts[i].product.id,
          quantity: demoCarts[i].numOfItem));
    }

    String JsonProducts = jsonEncode(ListItems);
    print(JsonProducts);

    String body = jsonEncode({
      "payment_method": "bacs",
      "payment_method_title": "Direct Bank Transfer",
      "set_paid": "true",
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
          "total": "0.00"
        }
      ]
    });

    // FormData formData = FormData.fromMap();
    NetworkCalls nc = new NetworkCalls();
    nc.createOrder(body).then((value) {
      final body = json.decode(value);

      String ohAddress = body['shipping']['address_1'] +
          " " +
          body['shipping']['address_2'] +
          " " +
          body['shipping']['city'] +
          " " +
          body['shipping']['state'] +
          " " +
          body['shipping']['country'] +
          " " +
          body['shipping']['postcode'];

      demoHistory.add(OrderHistory(
          id: body['id'],
          date: body['date_created'],
          amount: body['total'],
          address: ohAddress,
          products: ListItems,
          status: body['status']));

      ListItems.clear();
      print(ListItems.length);
      showToast(message: "Your Order has been Successfully Created");
      setState(() {
        isLoading = false;
        demoCarts.clear();
      });

      FocusScope.of(context).unfocus();
      Navigator.pop(context);
    });
  }

  getTotal() {
    if (demoCarts.length > 0) {
      for (int i = 0; i < demoCarts.length; i++) {
        double amount = double.parse(demoCarts[i].product.salePrice);
        double count = demoCarts[i].numOfItem.toDouble();
        total = total + (count * amount);
        total = double.parse((total).toStringAsFixed(2));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getTotal();
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
            Form(
              key: formKey,
              child: SingleChildScrollView(
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
                      FormError(errors: errors),
                      SizedBox(
                        height: getProportionateScreenHeight(40),
                      ),
                      DefaultButton(
                        text: "Next",
                        press: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            // if all are valid then go to success screen
                            KeyboardUtil.hideKeyboard(context);
                            FocusScope.of(context).unfocus();
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                1,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Form(
              key: formKey,
              child: SingleChildScrollView(
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
                      FormError(errors: errors),
                      SizedBox(
                        height: getProportionateScreenHeight(40),
                      ),
                      DefaultButton(
                        text: "Next",
                        press: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            // if all are valid then go to success screen
                            KeyboardUtil.hideKeyboard(context);
                            FocusScope.of(context).unfocus();
                            if (_pageController.hasClients) {
                              _pageController.animateToPage(
                                2,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SingleChildScrollView(
            //   child: Container(
            //     margin: EdgeInsets.all(10),
            //     child: Column(
            //       children: [
            //         HeadingText("Bank Details"),
            //         CreditCardWidget(
            //           cardNumber: cardNumber,
            //           expiryDate: expiryDate,
            //           cardHolderName: cardHolderName,
            //           cvvCode: cvvCode,
            //           showBackView: isCvvFocused,
            //           obscureCardNumber: true,
            //           obscureCardCvv: true,
            //           cardBgColor: kPrimaryLightColor,
            //         ),
            //         SingleChildScrollView(
            //           child: Column(
            //             children: <Widget>[
            //               CreditCardForm(
            //                 formKey: formKey,
            //                 obscureCvv: true,
            //                 obscureNumber: true,
            //                 cardNumber: cardNumber,
            //                 cvvCode: cvvCode,
            //                 cardHolderName: cardHolderName,
            //                 expiryDate: expiryDate,
            //                 cardNumberDecoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Number',
            //                   hintText: 'XXXX XXXX XXXX XXXX',
            //                 ),
            //                 expiryDateDecoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Expired Date',
            //                   hintText: 'XX/XX',
            //                 ),
            //                 cvvCodeDecoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'CVV',
            //                   hintText: 'XXX',
            //                 ),
            //                 cardHolderDecoration: const InputDecoration(
            //                   border: OutlineInputBorder(),
            //                   labelText: 'Card Holder',
            //                 ),
            //                 onCreditCardModelChange: onCreditCardModelChange,
            //                 themeColor: kPrimaryColor,
            //               ),
            //             ],
            //           ),
            //         ),
            //         SizedBox(
            //           height: getProportionateScreenHeight(10),
            //         ),
            //         DefaultButton(
            //           text: "Next",
            //           press: () {
            //             FocusScope.of(context).unfocus();
            //             if (formKey.currentState!.validate()) {
            //               if (_pageController.hasClients) {
            //                 _pageController.animateToPage(
            //                   3,
            //                   duration: const Duration(milliseconds: 300),
            //                   curve: Curves.easeInOut,
            //                 );
            //               }
            //             } else {
            //               print('invalid!');
            //             }
            //           },
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: isLoading
                  ? Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(20)),
                child: LoadingRotating.square(
                  borderColor: kPrimaryColor,
                ),
              ):  Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    HeadingText("Order Summary"),
                    Container(
                      height: getProportionateScreenHeight(200),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getProportionateScreenWidth(10)),
                          child: Scrollbar(
                            controller: _controllerOne,
                            isAlwaysShown: true,
                            child: ListView.builder(
                              itemCount: demoCarts.length,
                              itemBuilder: (context, index) => Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Dismissible(
                                  key: Key(
                                      demoCarts[index].product.id.toString()),
                                  child: CartCard(
                                      cart: demoCarts[index], check: 1),
                                  direction: DismissDirection.none,
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
                        Text(Fname.text + " " + Lname.text),
                        Text(Number.text),
                        Text(Email.text),
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
                        Text(Address.text),
                        Text(City.text +
                            ", " +
                            State.text +
                            ", " +
                            Country.text),
                        Text(Zip.text),
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
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   crossAxisAlignment: CrossAxisAlignment.stretch,
                    //   children: [
                    //     Text(
                    //       "Payment Details",
                    //       style: TextStyle(
                    //           fontStyle: FontStyle.normal,
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 18),
                    //     ),
                    //     Text(cardNumber),
                    //     Text(cardHolderName),
                    //     Text(expiryDate),
                    //     Text(cvvCode),
                    //   ],
                    // ),
                    SizedBox(
                      height: getProportionateScreenHeight(50),
                    ),
                    Row(
                      children: [
                        Text(
                          "Total: ",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.normal,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "\$$total",
                          style: TextStyle(
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                    DefaultButton(
                      text: "Proceed To Pay",
                      press: () {
                        setState(() {
                          isLoading = true;
                        });
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => UsePaypal(
                                sandboxMode: true,
                                clientId: "AaDUEOYIWJim7CWuPo4df0oEybME1So5SSPNWu-_qAK75Y50esgwyK1k82fLd15nCXqq3BEDy3aFGUPy",
                                secretKey: "EFa-jpjmCK2Xy9ipiL5-HCMJ4St74CXUQdUS2OQA8atHKE6pZe6jbifLqAgCNd7UB5FwtFJEi5cUqBu0",
                                returnURL: "https://samplesite.com/return",
                                cancelURL: "https://samplesite.com/cancel",
                                transactions: [
                                  {
                                    "amount": {
                                      "total": total.toString(),
                                      "currency": "USD",
                                      "details": {
                                        "subtotal": total.toString(),
                                        "shipping": '0',
                                        "shipping_discount": 0
                                      }
                                    },
                                    "description":
                                        "Payment for Goods Purchased",
                                    "payment_options": {
                                      "allowed_payment_method":
                                          "INSTANT_FUNDING_SOURCE"
                                    },
                                    "item_list": {
                                      "items": [
                                        {
                                          "name": "RedLabelDistrict Products",
                                          "quantity": 1,
                                          "price": total.toString(),
                                          "currency": "USD"
                                        }
                                      ],
                                    }
                                  }
                                ],
                                note:
                                    "Contact us for any questions on your order.",
                                onSuccess: (Map params) async {
                                  print("onSuccess: $params");
                                  orderCreate();
                                },
                                onError: (error) {
                                  print("onError: $error");
                                },
                                onCancel: (params) {
                                  print('cancelled: $params');
                                }),
                          ),
                        );
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
      keyboardType: TextInputType.number,
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
