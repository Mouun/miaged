extension FormValidation on String {
  bool isValidEmailAddress() => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(this);
  bool isValidPassword() => this.length >= 6;
}

extension Syntax on String {
  String capitalize() => this[0].toUpperCase() + this.substring(1);
}
