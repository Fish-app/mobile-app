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

  clearData() {
    this.newpwd = "";
    this.email = "";
    this.oldpwd = "";
  }
}
