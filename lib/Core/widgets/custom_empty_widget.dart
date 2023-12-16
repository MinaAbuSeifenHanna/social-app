import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:social_app/Core/utils/styles.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    this.title,
    this.subTitle,
    this.image,
  });

  final String? title, subTitle, image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: EmptyWidget(
        title: title,
        subTitle: subTitle,
        image: image,
        hideBackgroundAnimation: true,
        titleTextStyle: Styles.textStyle22,
      ),
    );
  }
}
