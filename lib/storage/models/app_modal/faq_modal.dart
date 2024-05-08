class BaseResponse {
 late String message;
 late List<FaqModal>? data;
 late String code;


  BaseResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['data'] != null) {
      data = <FaqModal>[];
      json['data'].forEach((v) {
        data?.add(FaqModal.fromJson(v));
      });
    }
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    return data;
  }
}

class FaqModal {
 late int id;
 late String arname;
 late String enname;
 late String createdAt;
 late List<QuestionsModal>? questions;


  FaqModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arname = json['arname'];
    enname = json['enname'];
    createdAt = json['created_at'];
    if (json['questions'] != null) {
      questions = <QuestionsModal>[];
      json['questions'].forEach((v) {
        questions?.add(QuestionsModal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['arname'] = arname;
    data['enname'] = enname;
    data['created_at'] = createdAt;
    if (questions != null) {
      data['questions'] = questions?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionsModal {
 late int id;
 late int category;
 late String arquestion;
 late String enquestion;
 late String aranswer;
 late String enanswer;
 late int deleted;
 late int suspensed;
 late String createdAt;

  

  QuestionsModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    arquestion = json['arquestion'];
    enquestion = json['enquestion'];
    aranswer = json['aranswer'];
    enanswer = json['enanswer'];
    deleted = json['deleted'];
    suspensed = json['suspensed'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category'] = category;
    data['arquestion'] = arquestion;
    data['enquestion'] = enquestion;
    data['aranswer'] = aranswer;
    data['enanswer'] = enanswer;
    data['deleted'] = deleted;
    data['suspensed'] = suspensed;
    data['created_at'] = createdAt;
    return data;
  }
}

//
//
// class BaseResponse {
//   late String message;
//   late List<FaqModel>? data;
//   late String code;
//
//
//   BaseResponse.fromJson(Map<String, dynamic> json) {
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <FaqModel>[];
//       json['data'].forEach((v) {
//         data?.add(FaqModel.fromJson(v));
//       });
//     }
//     code = json['code'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data?.map((v) => v.toJson()).toList();
//     }
//     data['code'] = this.code;
//     return data;
//   }
// }
//
//
//
// class FaqModel {
//   late int id;
//   late String arname;
//   late String enname;
//   late String createdAt;
//   late List<QuestionsModal>? questions;
//
//
//   FaqModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     arname = json['arname'];
//     enname = json['enname'];
//     createdAt = json['created_at'];
//     if (json['questions'] != null) {
//       questions = <QuestionsModal>[];
//       json['questions'].forEach((v) {
//         questions?.add( QuestionsModal.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['arname'] = this.arname;
//     data['enname'] = this.enname;
//     data['created_at'] = this.createdAt;
//     if (this.questions != null) {
//       data['questions'] = this.questions?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
//
// class QuestionsModal {
//   late int id;
//   late int category;
//   late String arquestion;
//   late String enquestion;
//   late String aranswer;
//   late String enanswer;
//   late int deleted;
//   late int suspensed;
//   late String createdAt;
//
//
//
//   QuestionsModal.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     category = json['category'];
//     arquestion = json['arquestion'];
//     enquestion = json['enquestion'];
//     aranswer = json['aranswer'];
//     enanswer = json['enanswer'];
//     deleted = json['deleted'];
//     suspensed = json['suspensed'];
//     createdAt = json['created_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['category'] = this.category;
//     data['arquestion'] = this.arquestion;
//     data['enquestion'] = this.enquestion;
//     data['aranswer'] = this.aranswer;
//     data['enanswer'] = this.enanswer;
//     data['deleted'] = this.deleted;
//     data['suspensed'] = this.suspensed;
//     data['created_at'] = this.createdAt;
//     return data;
//   }
// }