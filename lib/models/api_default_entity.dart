import 'package:pristine_seeds/generated/json/base/json_field.dart';
import 'package:pristine_seeds/generated/json/api_default_entity.g.dart';
import 'dart:convert';
export 'package:pristine_seeds/generated/json/api_default_entity.g.dart';

@JsonSerializable()
class ApiDefaultEntity {
	late String condition = "";
	late String message = "";

	ApiDefaultEntity();

	factory ApiDefaultEntity.fromJson(Map<String, dynamic> json) => $ApiDefaultEntityFromJson(json);

	Map<String, dynamic> toJson() => $ApiDefaultEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}