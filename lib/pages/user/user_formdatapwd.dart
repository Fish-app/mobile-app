class ResetPasswordFormData {
  String email;
  String oldpwd;
  String newpwd;


  toMap() {
    return {
      "email" : this.email,
      "pwd" : this.newpwd,
      "oldpwd" : this.oldpwd
    };
  }
}
