import 'package:json_annotation/json_annotation.dart';

part 'pagination_links.g.dart';

@JsonSerializable()
class PaginationLinks {
  final String? first;
  final String? last;
  final String? next;
  final String? prev;

  PaginationLinks({
    this.first,
    this.last,
    this.next,
    this.prev,
  });

  factory PaginationLinks.fromJson(Map<String, dynamic> json) =>
      _$PaginationLinksFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationLinksToJson(this);
}
