class UserModel {
  final String id;
  final String displayName;
  final String username;
  final List<String> roles;
  final bool active;
  final int experienceYears;
  final String address;
  final String level;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.displayName,
    required this.username,
    required this.roles,
    required this.active,
    required this.experienceYears,
    required this.address,
    required this.level,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      displayName: json['displayName'],
      username: json['username'],
      roles: List<String>.from(json['roles']),
      active: json['active'],
      experienceYears: json['experienceYears'],
      address: json['address'],
      level: json['level'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
