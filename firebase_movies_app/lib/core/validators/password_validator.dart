class PasswordValidator {
  static final PasswordValidator _singleton = PasswordValidator._internal();

  factory PasswordValidator() {
    return _singleton;
  }
  
  PasswordValidator._internal();

  static String? validate(String? password) {
    if(password == null || password.isEmpty) {
      return 'A senha é obrigatória' ;
    }else if (password.length < 6){
      return 'Sua senha deve conter pelo menos 6 caracteres';
    }else if(password.length > 200){
      return 'Sua senha deve conter no máximo 200 caracteres';
    }
    return null;
  }
}