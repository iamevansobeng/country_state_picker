import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AddressPicker());
}

class AddressPicker extends StatefulWidget {
  const AddressPicker({Key? key}) : super(key: key);

  @override
  State<AddressPicker> createState() => _AddressPickerState();
}

class _AddressPickerState extends State<AddressPicker> {
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
                CountryStatePicker(
                  onCountryChanged: (ct) => setState(() {
                    country = ct;
                    state = null;
                  }),
                  onStateChanged: (st) => setState(() {
                    state = st;
                  }),
                ),
                const SizedBox(height: 50),
                if (country != null)
                  Text("Country = $country",
                      style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 40),
                if (state != null)
                  Text("Country = $state", style: const TextStyle(fontSize: 18))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
