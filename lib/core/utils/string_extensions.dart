extension StringExt on String {
  ///Check if the email is valid
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z.]+.(com|pk|sa)+")
      .hasMatch(this);

  bool get isNumber => RegExp(r'\d+$').hasMatch(this);

  bool get isLink => RegExp(
        r"^(http|https)?(:\/\/)?([^\s$.?#]+[^\s]*)?[^\s]*$",
      ).hasMatch(this);

  String lastChars(int n) => substring(length - n);

  int get parseInt => int.parse(this);

  double get parseDouble => double.parse(this);
}
