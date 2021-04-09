class UserModel {
  final String uid;
  final bool isAnonymous;

  const UserModel({
    required this.uid,
    this.isAnonymous = false,
  });
}
