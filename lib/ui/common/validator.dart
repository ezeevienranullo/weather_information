
class FormValidators {
  static bool isFieldValid(String value) {
    if (value.isEmpty) {
      return false;
    }
    return true;
  }
}