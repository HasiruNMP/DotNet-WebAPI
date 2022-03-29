import 'package:flutter/material.dart';

TextField reusableTextField(
  controller,
  labelName,
) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      // filled: true,
      //  fillColor: Colors.white,
      labelText: labelName,
      //labelStyle: ,
      // suffixIcon: IconButton(
      //   onPressed: _toggle,
      //   icon: Icon(
      //     Icons.remove_red_eye_rounded,
      //     color: klblack,
      //   ),
      // ),
      // border: InputBorder.none,
    ),
  );
}
