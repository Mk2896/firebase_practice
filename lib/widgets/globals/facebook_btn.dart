import 'package:flutter/material.dart';

class FacebookButton extends StatelessWidget {
  const FacebookButton(
      {Key? key,
      required this.text,
      this.bottomMargin,
      this.topMargin,
      this.rightMargin,
      this.leftMargin,
      this.height,
      this.width})
      : super(key: key);
  final double? leftMargin;
  final double? rightMargin;
  final double? topMargin;
  final double? bottomMargin;
  final double? width;
  final double? height;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: leftMargin ?? 0,
        right: rightMargin ?? 0,
        top: topMargin ?? 0,
        bottom: bottomMargin ?? 0,
      ),
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 50,
              child:
                  Image(image: AssetImage("assets/images/facebook_logo.png")),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 20,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
