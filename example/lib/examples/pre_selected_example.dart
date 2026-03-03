import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';

/// Demonstrates [initialCountry] and [initialState].
/// Pass a country name or ISO2 code, and a state name or state code.
class PreSelectedExample extends StatefulWidget {
  const PreSelectedExample({Key? key}) : super(key: key);

  @override
  State<PreSelectedExample> createState() => _PreSelectedExampleState();
}

class _PreSelectedExampleState extends State<PreSelectedExample> {
  String? state;
  String? country;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pre-select a country and state on first load.\n'
            'Pass either the full name or the ISO2 / state code.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          CountryStatePicker(
            initialCountry: 'GH', // also accepts "Ghana"
            initialState: 'Ashanti', // also accepts state code
            onCountryChanged: (ct) => setState(() {
              country = ct;
              state = null;
            }),
            onStateChanged: (st) => setState(() => state = st),
          ),
          const SizedBox(height: 40),
          if (country != null)
            Text('Country: $country', style: const TextStyle(fontSize: 16)),
          if (state != null)
            Text('State: $state', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
