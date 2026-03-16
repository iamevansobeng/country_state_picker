library country_state_picker;

import 'dart:convert';

import 'package:country_state_picker/models/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'components/index.dart';
import 'utils/index.dart';

/// A form-friendly country and state/region picker widget.
///
/// The widget loads country/state data from a bundled JSON asset and renders
/// searchable dropdown inputs. Use [onCountryChanged] and [onStateChanged] to
/// receive selected values in your parent widget.
class CountryStatePicker extends StatefulWidget {
  /// Creates a [CountryStatePicker].
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
    this.initialCountry,
    this.initialState,
    this.showStateField = true,
    this.enabled = true,
    this.countryFilter,
  }) : super(key: key);

  /// Called when the selected country changes.
  final ValueChanged<String> onCountryChanged;

  /// Called when the selected state/region changes.
  final ValueChanged<String> onStateChanged;

  /// Validator for the country field.
  final ValidatorFunction? countryValidator;

  /// Validator for the state field.
  final ValidatorFunction? stateValidator;

  /// Called when the country dropdown is tapped.
  final VoidCallback? onCountryTap;

  /// Called when the state dropdown is tapped.
  final VoidCallback? onStateTap;

  /// Decoration applied to both dropdown form fields.
  final InputDecoration? inputDecoration;

  /// Emoji flag size for the selected country label.
  final double? flagSize;

  /// Emoji flag size for items in the country dropdown menu.
  final double? listFlagSize;

  /// Text style used by selected/hint text in the fields.
  final TextStyle? hintTextStyle;

  /// Text style used by dropdown menu items.
  final TextStyle? itemTextStyle;

  /// Background color for dropdown menus.
  final Color? dropdownColor;

  /// Elevation used by dropdown menus.
  final int? elevation;

  /// Whether dropdowns should expand to fill available width.
  final bool? isExpanded;

  /// Widget placed between the country and state fields.
  final Widget? divider;

  /// Widget rendered above the country field.
  final Widget? countryLabel;

  /// Widget rendered above the state field.
  final Widget? stateLabel;

  /// Hint text for the country field.
  final String? countryHintText;

  /// Hint text for the state field.
  final String? stateHintText;

  /// Text shown when a selected country has no states.
  final String? noStateFoundText;

  /// Pre-select a country by its name or ISO2 code (e.g. "United States" or "US").
  final String? initialCountry;

  /// Pre-select a state by its name or state code. Only applied when [initialCountry] is also set.
  final String? initialState;

  /// Whether to show the state dropdown. Defaults to [true].
  final bool showStateField;

  /// Whether both dropdowns are interactive. Defaults to [true].
  final bool enabled;

  /// When provided, only countries whose name or ISO2 code appears in this
  /// list will be shown. Example: `["US", "CA", "GB"]` or `["United States"]`.
  final List<String>? countryFilter;

  @override
  State<CountryStatePicker> createState() => _CountryStatePickerState();
}

class _CountryStatePickerState extends State<CountryStatePicker> {
  // Cache the full country list across all widget instances so the JSON asset
  // is only decoded once per app session.
  static List<Country>? _cachedCountries;

  List<Country> _countries = [];
  Country? selectedCountry;
  String? state;
  bool _initialised = false;

  /// Loads and decodes the bundled JSON, using the static cache when available.
  Future<List<Country>> _loadCountries() async {
    if (_cachedCountries != null) return _cachedCountries!;
    final raw = await rootBundle.loadString(
      'packages/country_state_picker/lib/utils/country-state.json',
    );
    final list = jsonDecode(raw) as List;
    _cachedCountries = list.map((ct) => Country.fromJson(ct)).toList();
    return _cachedCountries!;
  }

  Future<void> _fetchCountries() async {
    final all = await _loadCountries();

    // Apply optional country filter
    final filter = widget.countryFilter;
    final filtered = filter == null || filter.isEmpty
        ? all
        : all
              .where(
                (c) =>
                    filter.contains(c.name) ||
                    filter.contains(c.iso2.toUpperCase()),
              )
              .toList();

    Country? initial;
    String? initialStateName;

    if (!_initialised && widget.initialCountry != null) {
      final query = widget.initialCountry!;
      try {
        initial = filtered.firstWhere(
          (c) =>
              c.name.toLowerCase() == query.toLowerCase() ||
              c.iso2.toLowerCase() == query.toLowerCase(),
        );
      } catch (_) {
        // initialCountry not found — leave unselected
      }

      if (initial != null && widget.initialState != null) {
        final stQuery = widget.initialState!;
        try {
          initialStateName = initial.states
              .firstWhere(
                (s) =>
                    s.name.toLowerCase() == stQuery.toLowerCase() ||
                    s.stateCode.toLowerCase() == stQuery.toLowerCase(),
              )
              .name;
        } catch (_) {
          // initialState not found — leave unselected
        }
      }

      _initialised = true;
    }

    if (!mounted) return;
    setState(() {
      _countries = filtered;
      if (initial != null) {
        selectedCountry = initial;
        state = initialStateName;
      }
    });

    // Fire callbacks for pre-selected values so the parent stays in sync
    if (initial != null) {
      widget.onCountryChanged(initial.name);
      if (initialStateName != null) widget.onStateChanged(initialStateName);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // LABEL FOR COUNTRY FIELD
        widget.countryLabel ?? const Label(title: "Country"),

        // COUNTRY DROPDOWN
        DropdownButtonFormField<String>(
          validator: widget.countryValidator,
          decoration: widget.inputDecoration ?? defaultInputDecoration,
          hint: selectedCountry != null
              ? Row(
                  children: [
                    Text(
                      selectedCountry!.emoji,
                      style: TextStyle(fontSize: widget.flagSize ?? 22),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      selectedCountry!.name,
                      style:
                          widget.hintTextStyle ??
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
          // Passing null to onChanged causes Flutter to render the field as disabled
          onTap: widget.enabled ? widget.onCountryTap : null,
          onChanged: widget.enabled
              ? (value) {
                  final ct = _countries.firstWhere((c) => c.name == value);
                  setState(() {
                    selectedCountry = ct;
                    state = null;
                  });
                  widget.onCountryChanged(ct.name);
                }
              : null,
          items: _countries
              .map(
                (country) => DropdownMenuItem(
                  value: country.name,
                  child: Row(
                    children: [
                      Text(
                        country.emoji,
                        style: TextStyle(fontSize: widget.listFlagSize ?? 22),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        country.name,
                        style:
                            widget.itemTextStyle ??
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),

        // DIVIDER BETWEEN THE TWO FIELDS — only shown when state field is visible
        if (widget.showStateField) widget.divider ?? const SizedBox(height: 10),

        // STATE DROPDOWN — hidden when showStateField is false
        if (widget.showStateField) ...[
          widget.stateLabel ?? const Label(title: "State"),

          DropdownButtonFormField<String>(
            key: ValueKey(selectedCountry?.name),
            initialValue: state,
            validator: widget.stateValidator,
            decoration: widget.inputDecoration ?? defaultInputDecoration,
            hint: state != null
                ? Text(
                    state!,
                    style:
                        widget.hintTextStyle ??
                        const TextStyle(color: Colors.black, fontSize: 16),
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
            onTap: widget.enabled ? widget.onStateTap : null,
            onChanged: widget.enabled && selectedCountry != null
                ? (value) {
                    final st = selectedCountry!.states
                        .firstWhere((e) => e.name == value)
                        .name;
                    setState(() => state = st);
                    widget.onStateChanged(st);
                  }
                : null,
            items: selectedCountry == null
                ? []
                : selectedCountry!.states
                      .map(
                        (s) => DropdownMenuItem(
                          value: s.name,
                          child: Text(
                            s.name,
                            style:
                                widget.itemTextStyle ??
                                const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      )
                      .toList(),
          ),
        ],
      ],
    );
  }
}
