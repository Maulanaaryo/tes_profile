class ProfileResponseModel {
  final int code;
  final String message;
  final ProfileData data;

  ProfileResponseModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfileResponseModel(
      code: json['code'],
      message: json['message'],
      data: ProfileData.fromJson(json['data']),
    );
  }
}

class ProfileData {
  final String name;
  final String email;
  final String phone;
  final String moto;

  ProfileData({
    required this.name,
    required this.email,
    required this.phone,
    required this.moto,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      moto: json['moto'],
    );
  }
}