import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../all_colors.dart';
import '../../widget/registration/registration_large_text.dart';
import '../../widget/registration/registration_button.dart';
import '../../widget/registration/registration_text.dart';
import '../widget/registration/countdown_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _ResistrationScreenState();
}

class _ResistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  final TextEditingController _phoneController =
      MaskedTextController(mask: '+7(000) 000 00 00');
  final FocusNode _phoneFocusNode = FocusNode();
  String verificationCode = "56732";

  bool isPhoneNumberComplete = false;
  int index = 0;

  List<String> title = [
    "Регистрация",
    "Подтверждение",
    "",
  ];

  List<String> text = [
    "Введите номер телефона\nдля регистрации",
    "",
    "",
  ];

  List<String> textButton = [
    "Отправить смс-код",
    "Подтверждение",
    "",
  ];

  Widget _buildDotsRow() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Container(
            height: 1,
            width: 162,
            color: kNotActiveColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            title.length * 2 - 1,
            (indexDots) {
              // print("${index} ${indexDots}");
              if (indexDots.isEven) {
                final containerIndex = indexDots ~/ 2;
                return Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: index > containerIndex
                        ? Border.all(color: kBorderContainerColor, width: 1)
                        : null,
                    color: index == containerIndex
                        ? kActiveColor
                        : index < containerIndex
                            ? kNotActiveColor
                            : kWhiteColor,
                  ),
                  child: Center(
                    child: Text(
                      index <= containerIndex ? "${containerIndex + 1}" : "",
                    ),
                  ),
                );
              } else {
                final separatorIndex = indexDots ~/ 2;
                return SizedBox(
                  width: 44,
                  height: 36,
                  child: separatorIndex < index
                      ? const Padding(
                          padding: EdgeInsets.only(top: 18, right: 15),
                          child: Icon(
                            Icons.check,
                            color: kRegistrationButtonColor,
                            size: 20,
                          ),
                        )
                      : null,
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 120),
      child: WelcomeButton(
        textColor: kTextColor,
        buttonColor: index == 0
            ? isPhoneNumberComplete
                ? kActiveColor
                : kRegistrationButtonColor
            : kRegistrationButtonColor,
        textButton: textButton[index],
        indexDots: index,
        onPageChanged: (int newIndex) {
          _updateIndex("+", newIndex);
        },
      ),
    );
  }

  void _checkPhoneNumber() {
    setState(() {
      isPhoneNumberComplete = _phoneController.text.length == 17;
    });
  }

  void _updateIndex(String name, int newIndex) {
    switch (name) {
      case "+":
        if (newIndex == 1) {
          setState(() {
            text[newIndex] =
                "Введите код, который мы отправили\nв SMS на ${_phoneController.text}";
          });
        }
        setState(() {
          index = newIndex;
        });
        break;
      case "-":
        if (index != 0) {
          setState(() {
            index--;
          });
        }

        break;
      default:
        if (newIndex == 5 && verificationCode == "56732") {
          setState(() {
            index++;
          });
        }

        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        break;
    }
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_checkPhoneNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _phoneFocusNode.dispose();
    _phoneController.removeListener(_checkPhoneNumber);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () {
              _updateIndex("-", index);

              if (index != 0) {
                setState(() {
                  index--;
                });
              }
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            _buildDotsRow(),
            SizedBox(
              height: 414,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: title.length,
                itemBuilder: (_, index) {
                  // print(index);
                  if (index == 0) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Center(
                        child: Column(
                          children: [
                            AppLargeText(
                              text: title[index],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: AppText(
                                text: text[index],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: const Padding(
                                padding: EdgeInsets.only(top: 38),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Номер телефона",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: TextField(
                                controller: _phoneController,
                                focusNode: _phoneFocusNode,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                  hintText: '+7',
                                  hintStyle: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color: kTextFieldBorderColor,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      color:
                                          kActiveColor, // Оранжевый цвет окантовки при активации
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 12.0, horizontal: 20.0),
                                ),
                                onTap: () {
                                  if (_phoneController.text.isEmpty) {
                                    _phoneController.text = '+7(';
                                  }
                                },
                              ),
                            ),
                            _buildWelcomeButton(),
                          ],
                        ),
                      ),
                    );
                  } else if (index == 1) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Center(
                        child: Column(
                          children: [
                            AppLargeText(
                              text: title[index],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 24),
                              child: AppText(
                                text: text[index],
                              ),
                            ),
                            PinCodeTextField(
                              appContext: context,
                              length: 5,
                              onChanged: (value) {
                                _updateIndex("=", value.length);
                              },
                              textStyle: const TextStyle(
                                color: kTextColor,
                                fontSize: 28,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.phone,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                borderRadius: BorderRadius.circular(5.0),
                                fieldHeight: 40,
                                fieldWidth: 40,
                                activeColor: kRegistrationButtonColor,
                                inactiveColor: kRegistrationButtonColor,
                                selectedColor: kRegistrationButtonColor,
                                borderWidth: 2,
                              ),
                              cursorColor: const Color.fromARGB(0, 0, 0, 0),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 44),
                              child: CountdownButton(),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 24, left: 24, right: 24),
                      child: Center(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/main');
                              },
                              child: const Text("3"),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
