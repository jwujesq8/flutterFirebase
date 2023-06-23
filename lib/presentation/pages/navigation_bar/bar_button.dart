import 'package:flutter/material.dart';

class BarButton extends StatelessWidget {
  const BarButton({

    required this.onPressed,
    required this.icon,
    this.text = "",
    super.key,
  });

  final Function() onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(8),
      //width: 85,
      // height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 0.0,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: Colors.blueGrey,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 10.0,
              ),
            ),
          ],
        ),
      ),

    );
  }
}