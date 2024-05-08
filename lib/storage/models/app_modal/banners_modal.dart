class BannersModal {
 late int id;
  late String image;


  BannersModal.fromJson(Map<String, dynamic> json) {
    id = json['id']??0;
    image = json['image']??"";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    return data;
  }
}
