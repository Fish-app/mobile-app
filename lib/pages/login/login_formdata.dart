class LoginUserFormData {
  String email;
  String password;

  toMap() {
    return {
      "email" : this.email,
      "password" : this.password,
    };
  }
}
