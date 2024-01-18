
class Texture_ {
  int? id;
  String? name;
  String? type;
  String? imageData;


  Texture_({
    this.id,
    this.name,
    this.type,
    this.imageData
  });

  factory Texture_.fromJson(dynamic json) {
    return Texture_(
        id: json['id'] == null ? null : json['id'] as int,
        name: json['name'] == null ? null : json['name'] as String,
        type: json['type'] == null ? null : json['type'] as String,
        imageData: json['imageData'] == null ? null : json['imageData'] as String
        );
  }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'imageData': imageData,
      };

}
