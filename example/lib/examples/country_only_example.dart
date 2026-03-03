import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';

/// Demonstrates [showStateField] and [enabled].
///
/// [showStateField]: false hides the state dropdown entirely.
/// [enabled]: false makes the picker read-only — useful for review screens.
class CountryOnlyExample extends StatefulWidget {
  const CountryOnlyExample({Key? key}) : super(key: key);

  @override
  State<CountryOnlyExample> createState() => _CountryOnlyExampleState();
}

class _CountryOnlyExampleState extends State<CountryOnlyExample> {
  String? country;
  bool _locked = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'showStateField: false — show only the country dropdown.\n'
            'Toggle the lock to see enabled: false (read-only) mode.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          CountryStatePicker(
            showStateField: false,
            enabled: !_locked,
            initialCountry: 'GH',
            onCountryChanged: (ct) => setState(() => country = ct),
            onStateChanged: (_) {},
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              const Text('Lock picker (enabled: false)'),
              const SizedBox(width: 8),
              Switch(
                value: _locked,
                onChanged: (v) => setState(() => _locked = v),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (country != null)
            Text('Country: $country', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
