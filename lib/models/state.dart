/// State/region model for a country.
class State {
  /// State or region name.
  final String name;

  /// State code, when available.
  final String stateCode;

  /// Creates a [State] instance.
  State({
    required this.name,
    required this.stateCode,
  });

  /// Creates a [State] from JSON.
  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      name: json['name'] as String,
      stateCode: json['state_code'] as String,
    );
  }
}
