import 'package:flutter/material.dart';

import 'custom_colors.dart';

class ViewUtil {
  static Widget supersetIcon(Icon icon, String number) {
    return Stack(
      children: [
        icon,
        Positioned(
            top: -4.0,
            right: 4.0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                  color: CustomColors.redColor, shape: BoxShape.circle),
              child: Text(
                number,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500),
              ),
            )),
      ],
    );
  }
}
