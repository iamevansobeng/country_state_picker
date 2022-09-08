library country_state_picker;

import 'dart:convert';

import 'package:country_state_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  fillColor: Colors.grey.shade200,
  enabledBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withOpacity(0.6), width: 1.0),
  ),
);

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

  @override
  State<CountryStatePicker> createState() => _CountryStatePickerState();
}

class _CountryStatePickerState extends State<CountryStatePicker> {
  List<Country> _countries = [];

  Country? selectedCountry;

  String? state;

  Future fetchFile() async {
    var res = await rootBundle.loadString(
        'packages/country_state_picker/lib/utils/country-state.json');
    return jsonDecode(res);
  }

  Future fetchCountries() async {
    var data = await fetchFile() as List;
    _countries = data.map((ct) => Country.fromJson(ct)).toList();
  }

  @override
  void initState() {
    fetchCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            // onTap: widget.onCountryTap,
            // onChanged: (value) => _onSelectedCountry(value!),
            // value: _selectedCountry,
          ),
        ),

        /**
         * DIVIDER
         */
        widget.divider ?? const SizedBox(height: 10),

        /**
         * STATE PICKER
         */
        InputDecorator(
          decoration: _inputDecoration,
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
