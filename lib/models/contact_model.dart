class ContactModel {
  final int id;
  final String name;
  final String celularNumber;
  final String telephoneNumber;
  final int userId;
  final bool favorite;

  ContactModel({
    required this.id,
    required this.name,
    required this.celularNumber,
    required this.telephoneNumber,
    required this.userId,
    required this.favorite,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      celularNumber: json['celularNumber'] ?? '',
      telephoneNumber: json['telephoneNumber'] ?? '',
      userId: json['userId'] ?? 0,
      favorite: json['favorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'celularNumber': celularNumber,
      'telephoneNumber': telephoneNumber,
      'userId': userId,
      'favorite': favorite,
    };
  }
}
