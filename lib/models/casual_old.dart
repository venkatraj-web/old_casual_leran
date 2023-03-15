class Casual{
  int? id;
  String? casual_id;
  String? casual_name;
  String? email;
  String? password;
  int? casual_phone_no;
  int? city_id;
  DateTime? date_of_birth;
  String? gender;
  String? id_proof;
  String? casual_avatar;
  int? identification_number;
  String? id_card_front_photo;
  String? id_card_back_photo;
  String? qr_code;
  DateTime? email_verified_at;
  String? remember_token;
  DateTime? created_at;
  DateTime? updated_at;

  // Casual({this.id,this.casual_id,this.casual_name,this.email,this.password,this.casual_phone_no,this.city_id,
  // this.date_of_birth,this.gender,this.id_proof,this.casual_avatar,this.identification_number,this.id_card_front_photo,
  // this.id_card_back_photo,this.qr_code,this.email_verified_at,this.remember_token,this.created_at,
  // this.updated_at});

  Map<String, dynamic> toJson() {
    return {
      'id' : id.toString(),
      'casual_id' : casual_id.toString(),
      'casual_name' : casual_name.toString(),
      'email' : email,
      'password' : password,
    };

    // final Map<String, dynamic> data = new Map<String, dynamic>();
    //
    // data['id'] = this.id;
    // data['casual_id'] = this.casual_id;
    // data['casual_name'] = this.casual_name;
    // data['email'] = this.email;
    // data['password'] = this.password;
    // data['casual_phone_no'] = this.casual_phone_no;
    // data['city_id'] = this.city_id;
    // data['date_of_birth'] = this.date_of_birth;
    // data['gender'] = this.gender;
    // data['id_proof'] = this.id_proof;
    // data['casual_avatar'] = this.casual_avatar;
    // data['identification_number'] = this.identification_number;
    // data['id_card_front_photo'] = this.id_card_front_photo;
    // data['id_card_back_photo'] = this.id_card_back_photo;
    // data['qr_code'] = this.qr_code;
    // data['email_verified_at'] = this.email_verified_at;
    // data['remember_token'] = this.remember_token;
    // data['created_at'] = this.created_at;
    // data['updated_at'] = this.updated_at;
// print('toJson : ${data}');
//     return data;
  }

  Casual.fromJson(Map<String, dynamic> json){
    id = json['id'];
    casual_id = json['casual_id'];
    casual_name = json['casual_name'];
    email = json['email'];
    password = json['password'];
    casual_phone_no = json['casual_phone_no'];
    city_id = json['city_id'];
    date_of_birth = json['date_of_birth'];
    gender = json['gender'];
    id_proof = json['id_proof'];
    casual_avatar = json['casual_avatar'];
    identification_number = json['identification_number'];
    id_card_front_photo = json['id_card_front_photo'];
    qr_code = json['qr_code'];
    email_verified_at = json['email_verified_at'];
    remember_token = json['remember_token'];
    created_at = json['created_at'];
    updated_at = json['updated_at'];
  }

}