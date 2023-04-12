import 'package:hive/hive.dart';
part 'image_model.g.dart';

@HiveType(typeId: 0)
class ImageDataModel{
  @HiveField(0)
  final String bpNumber;
  @HiveField(1)
  final String lmcID;
  @HiveField(2)
  final String dmaID;
  @HiveField(3)
  final String image1;
  @HiveField(4)
  final String image2;
  @HiveField(5)
  final String image3;
  @HiveField(6)
  final String image4;

  ImageDataModel({
    this.bpNumber,
    this.lmcID,
    this.dmaID,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
  });

}