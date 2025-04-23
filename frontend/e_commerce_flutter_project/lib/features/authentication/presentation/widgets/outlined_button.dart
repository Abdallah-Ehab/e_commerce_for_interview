import 'package:flutter/material.dart';

class OutlinedButtonCustom extends StatelessWidget {
  final String label;
  final Widget icon;
  final VoidCallback onPressed;

  const OutlinedButtonCustom({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 20),
            Text(label,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),),
          ],
        ),
      ),
    );
  }
}
