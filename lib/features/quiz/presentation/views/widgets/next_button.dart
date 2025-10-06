import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.text,
    this.onTap,
    this.isNext = true,
  });
  final String text;
  final void Function()? onTap;
  final bool isNext;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 120,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Row(
            children: [
              Text(text, style: TextStyle(fontSize: 18)),
              Spacer(),
              isNext
                  ? Icon(Icons.arrow_forward_ios_outlined)
                  : Icon(Icons.arrow_back_ios_outlined),
            ],
          ),
        ),
      ),
    );
  }
}
