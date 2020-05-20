///Clase Modelo contenedor para
///usuarios propietarios de publicaciones
///provenientes desde la API de StackOverflow.
///
///Incluye recepción del payload básico
///desde su constructor factory.

class Owner {
  int reputation;
  int userId;
  String userType;
  int acceptRate;
  String profileImage;
  String displayName;
  String link;

  Owner(
      {this.reputation,
      this.userId,
      this.userType,
      this.acceptRate,
      this.profileImage,
      this.displayName,
      this.link});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return new Owner(
        reputation: json['reputation'],
        userId: json['user_id'],
        userType: json['user_type'],
        acceptRate: json['accept_rate'],
        profileImage: json['profile_image'],
        displayName: json['display_name'],
        link: json['link']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reputation'] = this.reputation;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['accept_rate'] = this.acceptRate;
    data['profile_image'] = this.profileImage;
    data['display_name'] = this.displayName;
    data['link'] = this.link;
    return data;
  }

  @override
  String toString() => this.toJson.toString();
}
