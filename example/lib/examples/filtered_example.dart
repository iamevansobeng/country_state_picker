import 'package:country_state_picker/country_state_picker.dart';
import 'package:flutter/material.dart';

/// Demonstrates [countryFilter] — restricts the list to a set of countries
/// identified by name or ISO2 code.
///
/// Allows switching between G7, BRICS, and ECOWAS trade blocs.
enum CountryGroup { g7, brics, ecowas }

class FilteredExample extends StatefulWidget {
  const FilteredExample({Key? key}) : super(key: key);

  @override
  State<FilteredExample> createState() => _FilteredExampleState();
}

class _FilteredExampleState extends State<FilteredExample> {
  String? state;
  String? country;
  CountryGroup _group = CountryGroup.g7;

  static const _filters = {
    CountryGroup.g7: {
      'label': 'G7',
      'description': 'Group of Seven industrialised nations.',
      'iso2': ['US', 'CA', 'GB', 'DE', 'FR', 'IT', 'JP'],
    },
    CountryGroup.brics: {
      'label': 'BRICS',
      'description':
          'Brazil, Russia, India, China, South Africa + 2024 members.',
      'iso2': ['BR', 'RU', 'IN', 'CN', 'ZA', 'EG', 'ET', 'IR', 'AE'],
    },
    CountryGroup.ecowas: {
      'label': 'ECOWAS',
      'description': 'Economic Community of West African States.',
      'iso2': [
        'BJ',
        'BF',
        'CV',
        'CI',
        'GM',
        'GH',
        'GN',
        'GW',
        'LR',
        'ML',
        'NE',
        'NG',
        'SN',
        'SL',
        'TG',
      ],
    },
  };

  @override
  Widget build(BuildContext context) {
    final selected = _filters[_group]!;
    final iso2List = selected['iso2']! as List<String>;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'countryFilter limits the list to specific countries.\n'
            'Pick a trade bloc to see only its member nations.',
            style: TextStyle(color: Colors.black54),
          ),
          const SizedBox(height: 16),
          SegmentedButton<CountryGroup>(
            segments: [
              for (final entry in _filters.entries)
                ButtonSegment(
                  value: entry.key,
                  label: Text(entry.value['label']! as String),
                ),
            ],
            selected: {_group},
            onSelectionChanged: (s) => setState(() {
              _group = s.first;
              country = null;
              state = null;
            }),
          ),
          const SizedBox(height: 8),
          Text(
            selected['description']! as String,
            style: const TextStyle(fontSize: 12, color: Colors.black45),
          ),
          const SizedBox(height: 16),
          // key forces a fresh widget when the bloc changes, resetting selections
          CountryStatePicker(
            key: ValueKey(_group),
            countryFilter: iso2List,
            countryLabel: Text(
              '${selected['label']} Country',
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54),
            ),
            stateLabel: const Text(
              'Region / State',
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.black54),
            ),
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
