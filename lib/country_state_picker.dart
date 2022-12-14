library country_state_picker;

import 'dart:convert';

import 'package:country_state_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

/// DEFAULT INPUT DECORATION
InputDecoration _inputDecoration = InputDecoration(
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
);

// WIDGET FOR LABEL

class Label extends StatelessWidget {
  const Label({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
      child: Text(
        title,
        style:
            const TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    );
  }
}

class CountryStatePicker extends StatefulWidget {
  const CountryStatePicker({
    Key? key,
    required this.onCountryChanged,
    required this.onStateChanged,
    this.onCountryTap,
    this.onStateTap,
    this.flagSize,
    this.listFlagSize,
    this.hintTextStyle,
    this.itemTextStyle,
    this.dropdownColor,
    this.elevation,
    this.isExpanded,
    this.divider,
    this.inputDecoration,
    this.countryLabel,
    this.stateLabel,
  }) : super(key: key);

  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;

  final VoidCallback? onCountryTap;
  final VoidCallback? onStateTap;

  final InputDecoration? inputDecoration;
  final double? flagSize;
  final double? listFlagSize;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;
  final Color? dropdownColor;
  final int? elevation;
  final bool? isExpanded;

  final Widget? divider;
  final Widget? countryLabel;
  final Widget? stateLabel;

  @override
  State<CountryStatePicker> createState() => _CountryStatePickerState();
}

class _CountryStatePickerState extends State<CountryStatePicker> {
  List<Country> _countries = [];

  Country? selectedCountry;

  String? state;

  /// GET COUNTRY AND CITIES FROM JSON
  Future fetchFile() async {
    var res = await rootBundle.loadString(
        'packages/country_state_picker/lib/utils/country-state.json');
    return jsonDecode(res);
  }

  // POPULATE STATE WITH COUNTRIES
  Future fetchCountries() async {
    var res = await fetchFile() as List;
    // ITERATE RESPONSET TO CREATE COUNTRIES AND STATES FOR EACH COUNTRY
    var data = res.map((ct) => Country.fromJson(ct)).toList();

    setState(() {
      _countries = data;
    });
  }

  @override
  void initState() {
    // MAKE SURE COUNTRIES ARE POPULATED BEFORE WIGET IS MOUNTED
    fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // LABEL FOR COUNTRY FIELD
        widget.countryLabel ?? const Label(title: "Country"),

        // COUNTRY FIELD
        InputDecorator(
          decoration: widget.inputDecoration ?? _inputDecoration,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                hint: selectedCountry != null
                    ? Row(
                        children: [
                          Text(
                            selectedCountry!.emoji,
                            style: TextStyle(
                              fontSize: widget.flagSize ?? 22,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            selectedCountry!.name,
                            style: widget.hintTextStyle ??
                                const TextStyle(
                                    color: Colors.black, fontSize: 16),
                          ),
                        ],
                      )
                    : const Text("Choose Country"),
                dropdownColor: widget.dropdownColor ?? Colors.grey.shade100,
                elevation: widget.elevation ?? 0,
                isExpanded: widget.isExpanded ?? true,
                items: [
                  // CREARE LIST ITEMS FROM COUNTRIES DATA
                  ..._countries
                      .map(
                        (country) => DropdownMenuItem(
                          value: country.name,
                          child: Row(
                            children: [
                              Text(
                                country.emoji,
                                style: TextStyle(
                                  fontSize: widget.listFlagSize ?? 22,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                country.name,
                                style: widget.itemTextStyle ??
                                    const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
                onTap: widget.onCountryTap,
                onChanged: (value) {
                  var ct = _countries.firstWhere((c) => c.name == value);

                  setState(() {
                    selectedCountry = ct;
                    state = null;
                  });
                  widget.onCountryChanged(ct.name);
                }),
          ),
        ),

        /**
         * DIVIDER TO SEPRATE THE TWO FIELDS
         */
        widget.divider ?? const SizedBox(height: 10),

        // LAGE FOR STATE PICKER
        widget.stateLabel ?? const Label(title: "State"),

        //STATE PICKER
        InputDecorator(
          decoration: widget.inputDecoration ?? _inputDecoration,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
                hint: state != null
                    ? Row(
                        children: [
                          Text(
                            state!,
                            style: widget.hintTextStyle ??
                                const TextStyle(
                                    color: Colors.black, fontSize: 16),
                          ),
                        ],
                      )
                    : const Text("Choose State"),
                dropdownColor: widget.dropdownColor ?? Colors.grey.shade100,
                elevation: widget.elevation ?? 0,
                isExpanded: widget.isExpanded ?? true,
                items: selectedCountry == null
                    ? []
                    : [
                        // MAP STATES OF SELECTED COUNTRY
                        ...selectedCountry!.states
                            .map(
                              (state) => DropdownMenuItem(
                                value: state.name,
                                child: Row(
                                  children: [
                                    Text(
                                      state.name,
                                      style: widget.itemTextStyle ??
                                          const TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                onTap: widget.onStateTap,
                onChanged: (value) {
                  var st = selectedCountry!.states
                      .firstWhere((e) => e.name == value)
                      .name;

                  setState(() {
                    state = st;
                  });
                  widget.onStateChanged(st);
                }),
          ),
        ),
      ],
    );
  }
}
