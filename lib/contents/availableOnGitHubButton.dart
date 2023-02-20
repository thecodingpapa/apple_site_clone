import 'package:flutter/material.dart';

class AvailableOnGithubButton extends StatelessWidget {
  const AvailableOnGithubButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {},
        child: Image.asset(
          'imgs/available_on_github.png',
          width: 200,
        ),
        style: TextButton.styleFrom(
            padding: EdgeInsets.zero, backgroundColor: Colors.transparent),
      ),
    );
  }
}
