import 'package:country_state_picker/models/state.dart';

class Country {
  final String name,
      iso2,
      iso3,
      phoneCode,
      currencyName,
      currencySymbol,
      tld,
      region,
      // subRegion,
      emoji,
      emojiU;
  final List<State> states;

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

  // FORMAT JSON TO DART OBJECT
  factory Country.fromJson(Map<String, dynamic> json) {
    var states = <State>[];
    // ITERATE OVER JSON TO CREATE STATES FOR THE COUNTRY
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
