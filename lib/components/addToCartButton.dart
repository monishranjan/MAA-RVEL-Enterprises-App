import 'package:flutter/material.dart';

class AddToCartButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const AddToCartButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(),
      ),
    );
  }
}
