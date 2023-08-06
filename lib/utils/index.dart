import 'package:flutter/material.dart';

/// DEFAULT INPUT DECORATION
InputDecoration defaultInputDecoration = InputDecoration(
    prefixStyle: const TextStyle(color: Colors.blueGrey),
    focusColor: Colors.blueGrey,
    iconColor: Colors.blueGrey,
    prefixIconColor: Colors.blueGrey,
    suffixIconColor: Colors.blueGrey,
    suffixStyle: const TextStyle(color: Colors.blueGrey),
    errorStyle: const TextStyle(color: Colors.redAccent),
    errorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 0.8),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
    ),
    filled: true,
    contentPadding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
    fillColor: Colors.grey.shade200,
    enabledBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 2.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0),
    ),
    border: InputBorder.none);

// TYPEDEF FOR VALIDATOR
typedef ValidatorFunction = String Function(String? value);
