// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as num,
    name: json['name'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('username', instance.username);
  writeNotNull('email', instance.email);
  return val;
}

Seller _$SellerFromJson(Map<String, dynamic> json) {
  return Seller(
    id: json['id'] as num,
    name: json['name'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    bankAccountNumber: json['bankAccountNumber'] as String,
    regNumber: json['regNumber'] as String,
  );
}

Map<String, dynamic> _$SellerToJson(Seller instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('username', instance.username);
  writeNotNull('email', instance.email);
  writeNotNull('bankAccountNumber', instance.bankAccountNumber);
  writeNotNull('regNumber', instance.regNumber);
  return val;
}
