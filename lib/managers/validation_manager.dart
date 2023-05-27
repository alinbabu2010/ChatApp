import 'package:chat_app/utils/constants.dart';

class ValidationManager {
  static ValidationManager? _validationManager;

  ValidationManager();

  static ValidationManager get instance =>
      _validationManager ?? ValidationManager();

  String? isValidEmail(String? value) {
    if (value?.isEmpty == true || value?.contains('@') == false) {
      return Constants.emailErrorMsg;
    }
    return null;
  }

  String? isValidPassword(String? value) {
    if (value?.isEmpty == true ||
        value?.length.compareTo(8).isNegative == true) {
      return Constants.passwordErrorMsg;
    }
    return null;
  }

  String? isValidUsername(String? value) {
    if (value?.isEmpty == true ||
        value?.length.compareTo(4).isNegative == true) {
      return Constants.usernameErrorMsg;
    }
    return null;
  }
}
