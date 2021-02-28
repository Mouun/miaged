extension FormValidation on String {
  bool isValidPassword() => this.length >= 4;

  bool isValidPostalCode() => RegExp(r"^[0-9]{5}$").hasMatch(this);
}

extension Syntax on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}
