import 'dart:async';

import 'package:flutter/material.dart';

class CustomOtpScreen extends StatefulWidget {
  static const String routeName = 'CustomOtpScreenInForgetPass';
  @override
  _CustomOtpScreenState createState() => _CustomOtpScreenState();
}

class _CustomOtpScreenState extends State<CustomOtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Otp Screen',
          style: TextStyle(
            fontSize: 19.0,
          ),
        ),
      ),
      body: OtpScreen(),
    );
  }
}

class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  List<String> currentPin = ["", "", "", ""];
  Timer _timer;
  int _start = 45;
  bool _timerFinished = false;
  bool _isRequestResend = false;
  bool _isPinCorrect = true;
  bool _isLoading = false;
  TextEditingController pinOneController = TextEditingController();
  TextEditingController pinTwoController = TextEditingController();
  TextEditingController pinThreeController = TextEditingController();
  TextEditingController pinFourController = TextEditingController();
  var outLineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10.0),
    borderSide: BorderSide(color: Colors.red),
  );

  int pinIndex = 0;

  void startTimer() {
    const onSec = Duration(seconds: 1);
    _timer = Timer.periodic(onSec, (Timer timer) {
      setState(() {
        if (_start < 1) {
          timer.cancel();
          setState(() {
            _timerFinished = true;
          });
        } else {
          _start = _start - 1;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget pinNumber(TextEditingController editingController,
      OutlineInputBorder outlineInputBorder) {
    return Container(
      width: 55.0,
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border:
            Border.all(color: _isPinCorrect ? Colors.transparent : Colors.red),
      ),
      child: TextField(
        enabled: false,
        controller: editingController,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            border: outlineInputBorder,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.1)),
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25.2,
        ),
      ),
    );
  }

  _resendConfirmationCode() {
    setState(() {
      _isRequestResend = true;
    });
    startTimer();
    setState(() {
      _timerFinished = false;
      _start = 45;
    });

    _isRequestResend = false;
  }

  _submitForm() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text('123'),
            ));
  }

  var forgetMethod;
  @override
  Widget build(BuildContext context) {
    forgetMethod = ModalRoute.of(context).settings.arguments as Map;
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Enter Verification Code here',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              buildPinRow(),
              SizedBox(
                height: 40.0,
              ),
              buildResendNumber(),
              SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
        Expanded(child: buildNumberPad()),
      ],
    );
  }

  buildPinRow() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            pinNumber(
              pinOneController,
              outLineBorder,
            ),
            pinNumber(
              pinTwoController,
              outLineBorder,
            ),
            pinNumber(
              pinThreeController,
              outLineBorder,
            ),
            pinNumber(
              pinFourController,
              outLineBorder,
            ),
          ],
        ),
      ),
    );
  }

  buildResendNumber() {
    return _timerFinished
        ? Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Don\'t Recive code? ',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _resendConfirmationCode();
                  },
                  child: Text(
                    'Resend',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 120.0,
            height: 30.0,
            alignment: Alignment.center,
            child: Text(
              '00:$_start',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
          );
  }

  buildNumberPad() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30.0),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(
                      n: 1,
                      onPressed: () {
                        pinIndexSetup("1");
                      }),
                  KeyBoardNumber(
                      n: 2,
                      onPressed: () {
                        pinIndexSetup("2");
                      }),
                  KeyBoardNumber(
                      n: 3,
                      onPressed: () {
                        pinIndexSetup("3");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(
                      n: 4,
                      onPressed: () {
                        pinIndexSetup("4");
                      }),
                  KeyBoardNumber(
                      n: 5,
                      onPressed: () {
                        pinIndexSetup("5");
                      }),
                  KeyBoardNumber(
                      n: 6,
                      onPressed: () {
                        pinIndexSetup("6");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  KeyBoardNumber(
                      n: 7,
                      onPressed: () {
                        pinIndexSetup("7");
                      }),
                  KeyBoardNumber(
                      n: 8,
                      onPressed: () {
                        pinIndexSetup("8");
                      }),
                  KeyBoardNumber(
                      n: 9,
                      onPressed: () {
                        pinIndexSetup("9");
                      }),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 70.0,
                    height: 70.0,
                    child: MaterialButton(onPressed: null),
                  ),
                  KeyBoardNumber(
                      n: 0,
                      onPressed: () {
                        pinIndexSetup("0");
                      }),
                  Container(
                    width: 70.0,
                    height: 70.0,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.2)),
                    child: MaterialButton(
                      onPressed: () {
                        clearPin();
                      },
                      child: Icon(Icons.clear),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pinIndexSetup(String s) {
    if (pinIndex == 0)
      pinIndex = 1;
    else if (pinIndex < 4) pinIndex++;
    sePin(pinIndex, s);
    currentPin[pinIndex - 1] = s;
    var strPin = "";
    currentPin.forEach((p) {
      strPin += p;
    });
    if (pinIndex == 4) {
      if (strPin == forgetMethod['otp'].toString()) {
        setState(() {
          _isPinCorrect = true;
        });
        _submitForm();
      } else {
        setState(() {
          _isPinCorrect = false;
        });
      }
    }
  }

  void sePin(int pinIndex, String s) {
    switch (pinIndex) {
      case 1:
        pinOneController.text = s;
        break;
      case 2:
        pinTwoController.text = s;
        break;
      case 3:
        pinThreeController.text = s;
        break;
      case 4:
        pinFourController.text = s;
        break;
    }
  }

  void clearPin() {
    print('pin: $pinIndex');
    if (pinIndex == 0) {
      pinIndex = 0;
      return;
    } else if (pinIndex <= 4) sePin(pinIndex, "");
    currentPin[pinIndex - 1] = "";
    pinIndex--;
    setState(() {
      _isPinCorrect = true;
    });
  }
}

class KeyBoardNumber extends StatelessWidget {
  final int n;
  final Function onPressed;
  KeyBoardNumber({this.n, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70.0,
      height: 70.0,
      decoration: BoxDecoration(
          shape: BoxShape.circle, color: Colors.grey.withOpacity(0.2)),
      alignment: Alignment.center,
      child: MaterialButton(
        padding: const EdgeInsets.only(
            left: 8.0, top: 10.0, right: 8.0, bottom: 4.0),
        onPressed: onPressed,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(70.0)),
        height: 70.0,
        child: Text(
          "$n",
          style: TextStyle(
              fontSize: 30 * MediaQuery.of(context).textScaleFactor,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
