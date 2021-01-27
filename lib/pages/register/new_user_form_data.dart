class NewUserFormDate {
  String name;
  String password;
  String email;

  toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
    };
  }
}