import 'package:flutter/material.dart';

import '../DeviceManager/text_styles.dart';

class TextFormFieldTitle extends StatelessWidget {
  final String title;

  const TextFormFieldTitle({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.titleFieldTextStyle,
    );
  }
}
