class ErrorRegister {
  ErrorRegister({
    required this.message,
    required this.errors,
  });
  late final String message;
  late final Errors errors;

  ErrorRegister.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = Errors.fromJson(json['errors']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['errors'] = errors.toJson();
    return _data;
  }
}

class Errors {
  Errors({
    required this.nama,
    required this.email,
    required this.password,
    required this.validasiPassword,
  });
  late final List<String> nama;
  late final List<String> email;
  late final List<String> password;
  late final List<String> validasiPassword;

  Errors.fromJson(Map<String, dynamic> json) {
    nama = List.castFrom<dynamic, String>(json['nama']);
    email = List.castFrom<dynamic, String>(json['email']);
    password = List.castFrom<dynamic, String>(json['password']);
    validasiPassword =
        List.castFrom<dynamic, String>(json['validasi_password']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['nama'] = nama;
    _data['email'] = email;
    _data['password'] = password;
    _data['validasi_password'] = validasiPassword;
    return _data;
  }
}
