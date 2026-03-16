import 'package:country_state_picker/models/state.dart';

/// Country model used by [CountryStatePicker].
class Country {
  /// Country display name, e.g. "Ghana".
  final String name;

  /// ISO-3166 alpha-2 code, e.g. "GH".
  final String iso2;

  /// ISO-3166 alpha-3 code, e.g. "GHA".
  final String iso3;

  /// International phone code, e.g. "233".
  final String phoneCode;

  /// Currency name, e.g. "Ghanaian cedi".
  final String currencyName;

  /// Currency symbol, e.g. "GH₵".
  final String currencySymbol;

  /// Top-level domain, e.g. ".gh".
  final String tld;

  /// Region name, e.g. "Africa".
  final String region;
  // subRegion,

  /// Country flag emoji.
  final String emoji;

  /// Unicode sequence for the flag emoji.
  final String emojiU;

  /// List of states/regions for this country.
  final List<State> states;

  /// Creates a [Country] instance.
  Country({
    required this.states,
    required this.name,
    required this.iso2,
    required this.iso3,
    required this.phoneCode,
    required this.currencyName,
    required this.currencySymbol,
    required this.tld,
    required this.region,
    required this.emoji,
    required this.emojiU,
  });

  /// Creates a [Country] from JSON.
  factory Country.fromJson(Map<String, dynamic> json) {
    var states = <State>[];
    // Iterate over JSON to create states for the country.
    json["states"].forEach((st) => states.add(State.fromJson(st)));
    return Country(
      states: states,
      region: json["region"] as String,
      name: json["name"] as String,
      iso2: json["iso2"] as String,
      iso3: json["iso3"] as String,
      phoneCode: json["phone_code"] as String,
      currencyName: json["currency_name"] as String,
      currencySymbol: json["currency_symbol"] as String,
      tld: json["tld"] as String,
      emoji: json["emoji"] as String,
      emojiU: json["emojiU"] as String,
    );
  }
}
