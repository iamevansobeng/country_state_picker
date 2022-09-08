class State {
  final String name, stateCode;

  State({
    required this.name,
    required this.stateCode,
  });

  // FROMAT JSON TO DART OBJECT
  factory State.fromJson(Map<String, dynamic> json) {
    return State(
      name: json['name'] as String,
      stateCode: json['state_code'] as String,
    );
  }
}
