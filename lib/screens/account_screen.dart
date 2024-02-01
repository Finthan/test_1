import 'package:flutter/material.dart';

import '../all_colors.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPhotoLoaded = false;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Stack(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: kIconColor,
                      foregroundColor: kActiveColor,
                      radius: 50, // Радиус круглой рамки
                      // backgroundImage: isPhotoLoaded ? AssetImage('path_to_photo') : AssetImage('path_to_placeholder_icon'),
                      child: isPhotoLoaded
                          ? null
                          : const Icon(
                              Icons.person,
                              size: 68,
                            ), // Иконка человечка
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 65, left: 60),
                      child: IconButton(
                        onPressed: () {},
                        icon: const CircleAvatar(
                          backgroundColor: kWhiteColor,
                          radius: 16,
                          child: Icon(
                            Icons.more_horiz,
                            color: kActiveColor,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              "apollo@gmail.com",
              style: TextStyle(color: kTextColor),
            ),
            Padding(
              padding: EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AccountButtom(title: "Имя"),
                  AccountButtom(title: "Фамилия"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AccountButtom extends StatelessWidget {
  final String title;
  const AccountButtom({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16), // Установите нужные значения отступов
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(color: kTextColor),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            children: [
              Text(
                "Настроить",
                style: TextStyle(color: kButtonAccountColor),
                textAlign: TextAlign.right,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: kButtonAccountColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
