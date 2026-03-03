import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';

/// Basic usage — user picks country and state freely.
class BasicExample extends StatefulWidget {
  const BasicExample({Key? key}) : super(key: key);

  @override
  State<BasicExample> createState() => _BasicExampleState();
}

class _BasicExampleState extends State<BasicExample> {
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
            'Standard picker — user chooses everything.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          CountryStatePicker(
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
