import 'package:country_state_picker/components/index.dart';
import 'package:flutter/material.dart';

// IMPORT COUNTRY STATE PICKER
import 'package:country_state_picker/country_state_picker.dart';

void main() {
  runApp(const AddressPicker());
}

class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
  // DECLARE STATE VARIABLES
  String? state;
  String? country;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // IMPLEMENT WIDGET
                CountryStatePicker(
                  countryLabel: const Label(title: "País"),
                  stateLabel: const Label(title: "Estado"),
                  onCountryChanged: (ct) => setState(() {
                    country = ct;
                    state = null;
                  }),
                  onStateChanged: (st) => setState(() {
                    state = st;
                  }),
                  // A little Spanish hint
                  countryHintText: "Elige País",
                  stateHintText: "Elige Estado",
                  noStateFoundText: "Ningún Estado",
                ),
                const SizedBox(height: 50),
                if (country != null)
                  Text("Country = $country",
                      style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 40),
                if (state != null)
                  Text("State = $state", style: const TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
