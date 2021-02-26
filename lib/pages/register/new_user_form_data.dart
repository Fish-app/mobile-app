import 'package:fishapp/pages/login/login_formdata.dart';

class NewUserFormData extends LoginUserFormData {
  String name;

  toMap() {
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password,
    };
  }
}
