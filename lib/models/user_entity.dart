class UserEntity {
  final int id;
  final String fullName;
  final String email;
  final String? pictureImageUrl;

  UserEntity({
    required this.id,
    required this.fullName,
    required this.email,
    this.pictureImageUrl,
  });
}
