import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'number_captcha.dart';

class NumberCaptchaDialog extends StatefulWidget {
  const NumberCaptchaDialog(
      this.titleText, this.placeholderText, this.checkCaption,
      {Key? key})
      : super(key: key);

  final String titleText;
  final String placeholderText;
  final String checkCaption;

  @override
  State<NumberCaptchaDialog> createState() => _NumberCaptchaDialogState();
}

class _NumberCaptchaDialogState extends State<NumberCaptchaDialog> {
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String code = '';

  bool? isValid;

  @override
  initState() {
    generateCode();
    super.initState();
  }

  void generateCode() {
    Random random = Random();
    code = (random.nextInt(9000) + 1000).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Material(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    widget.titleText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberCaptcha(
                      code,
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(
                          Radius.circular(3),
                        ),
                      ),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            generateCode();
                          },
                          child: const Icon(
                            Icons.refresh,
                            color: Colors.white,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isValid == false ? Colors.red : Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textController,
                          autofocus: true,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: widget.placeholderText,
                          ),
                          keyboardType: TextInputType.phone,
                          onSubmitted: (String value) {
                            isValid = null;
                            if (textController.text == code) {
                              isValid = true;
                              Navigator.pop(context, true);
                            } else {
                              isValid = false;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              isValid = null;
                              if (textController.text == code) {
                                isValid = true;
                                Navigator.pop(context, true);
                              } else {
                                isValid = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.checkCaption,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isValid == false ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: const <Widget>[
                        Text(
                          'Invalid code',
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
