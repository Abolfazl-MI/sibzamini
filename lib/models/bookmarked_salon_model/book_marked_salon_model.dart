import 'package:json_annotation/json_annotation.dart';
part 'book_marked_salon_model.g.dart';

@JsonSerializable()
class BookMarkedSalon {
  int? id;
  int ? shop;
  String ? name;
  String ? address;
  String ? pic;
  // String get imgUrl=>'';
  String  get imgurl =>'https://sunict.ir$pic';
  // double  get rateToDouble=>rate!=null?rate!.toDouble():0.0;
  BookMarkedSalon({
    this.id,
    this.shop,
    this.name,
    this.address,
    this.pic,
  });
  factory BookMarkedSalon.fromJson(Map<String,dynamic>json)=>_$BookMarkedSalonFromJson(json);
  Map<String,dynamic>toJson()=>_$BookMarkedSalonToJson(this);
}
