extension StringExt on String {
  //Check if the email is valid
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z.]+.(com|pk)+")
      .hasMatch(this);
}
