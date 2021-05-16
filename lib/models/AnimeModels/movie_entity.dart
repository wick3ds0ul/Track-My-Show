import 'package:equatable/equatable.dart';

class AnimeEntity extends Equatable {
  final String id;
  final String title;
  //Add more attributes here

  AnimeEntity({this.id, this.title});

  @override
  List<Object> get props => [id, title];
  @override
  bool get stringify => true;
}
