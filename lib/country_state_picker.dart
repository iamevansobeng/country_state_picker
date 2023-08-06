library country_state_picker;

import 'dart:convert';

import 'package:country_state_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'components/index.dart';
import 'utils/index.dart';

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
    this.countryHintText,
    this.stateHintText,
    this.noStateFoundText,
    this.stateValidator,
    this.countryValidator,
  }) : super(key: key);

  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;

  final ValidatorFunction? countryValidator;
  final ValidatorFunction? stateValidator;

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

  final String? countryHintText;
  final String? stateHintText;
  final String? noStateFoundText;

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
    // ITERATE RESPONSE TO CREATE COUNTRIES AND STATES FOR EACH COUNTRY
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
        DropdownButtonFormField<String>(
            validator: widget.countryValidator,
            decoration: widget.inputDecoration ?? defaultInputDecoration,
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
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  )
                : hintText(
                    widget.countryHintText ?? 'Choose Country',
                    style: widget.hintTextStyle,
                  ),
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

        /**
         * DIVIDER TO SEPRATE THE TWO FIELDS
         */
        widget.divider ?? const SizedBox(height: 10),

        // LAGE FOR STATE PICKER
        widget.stateLabel ?? const Label(title: "State"),

        //STATE PICKER

        DropdownButtonFormField<String>(
            validator: widget.stateValidator,
            decoration: widget.inputDecoration ?? defaultInputDecoration,
            hint: state != null
                ? Row(
                    children: [
                      Text(
                        state!,
                        style: widget.hintTextStyle ??
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  )
                : selectedCountry != null && selectedCountry!.states.isEmpty
                    ? Text(widget.noStateFoundText ?? "No States Found")
                    : hintText(
                        widget.stateHintText ?? 'Choose State',
                        style: widget.hintTextStyle,
                      ),
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
                                          color: Colors.black, fontSize: 16),
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
      ],
    );
  }
}
