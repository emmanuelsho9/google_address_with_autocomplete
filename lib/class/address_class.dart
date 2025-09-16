
import 'dart:convert';

GoogleMapClassPrediction googleMapClassPredictionFromJson(String str) =>
    GoogleMapClassPrediction.fromJson(json.decode(str));

String googleMapClassPredictionToJson(GoogleMapClassPrediction data) =>
    json.encode(data.toJson());

class GoogleMapClassPrediction {
  List<PredictionGoogle>? predictions;
  String? status;

  GoogleMapClassPrediction({
    this.predictions,
    this.status,
  });

  void clear() {
    predictions = [];
    status = "";
  }

  GoogleMapClassPrediction copyWith({
    List<PredictionGoogle>? predictions,
    String? status,
  }) =>
      GoogleMapClassPrediction(
        predictions: predictions ?? this.predictions,
        status: status ?? this.status,
      );

  factory GoogleMapClassPrediction.fromJson(Map<String, dynamic> json) =>
      GoogleMapClassPrediction(
        predictions: json["predictions"] == null
            ? []
            : List<PredictionGoogle>.from(
                json["predictions"]!.map((x) => PredictionGoogle.fromJson(x))),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "predictions": predictions == null
            ? []
            : List<dynamic>.from(predictions!.map((x) => x.toJson())),
        "status": status,
      };
}

class PredictionGoogle {
  String? description;
  List<MatchedSubstringGoogle>? matchedSubstrings;
  String? placeId;
  String? reference;
  StructuredFormattingGoogle? structuredFormatting;
  List<TermGoogle>? terms;
  List<String>? types;

  PredictionGoogle({
    this.description,
    this.matchedSubstrings,
    this.placeId,
    this.reference,
    this.structuredFormatting,
    this.terms,
    this.types,
  });

  void clear() {
    placeId = "";
    description = "";
    matchedSubstrings = [];
    reference = "";
    structuredFormatting = null;
    terms = [];
    types = [];
  }

  PredictionGoogle copyWith({
    String? description,
    List<MatchedSubstringGoogle>? matchedSubstrings,
    String? placeId,
    String? reference,
    StructuredFormattingGoogle? structuredFormatting,
    List<TermGoogle>? terms,
    List<String>? types,
  }) =>
      PredictionGoogle(
        description: description ?? this.description,
        matchedSubstrings: matchedSubstrings ?? this.matchedSubstrings,
        placeId: placeId ?? this.placeId,
        reference: reference ?? this.reference,
        structuredFormatting: structuredFormatting ?? this.structuredFormatting,
        terms: terms ?? this.terms,
        types: types ?? this.types,
      );

  factory PredictionGoogle.fromJson(Map<String, dynamic> json) => PredictionGoogle(
        description: json["description"],
        matchedSubstrings: json["matched_substrings"] == null
            ? []
            : List<MatchedSubstringGoogle>.from(json["matched_substrings"]!
                .map((x) => MatchedSubstringGoogle.fromJson(x))),
        placeId: json["place_id"],
        reference: json["reference"],
        structuredFormatting: json["structured_formatting"] == null
            ? null
            : StructuredFormattingGoogle.fromJson(json["structured_formatting"]),
        terms: json["terms"] == null
            ? []
            : List<TermGoogle>.from(json["terms"]!.map((x) => TermGoogle.fromJson(x))),
        types: json["types"] == null
            ? []
            : List<String>.from(json["types"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "matched_substrings": matchedSubstrings == null
            ? []
            : List<dynamic>.from(matchedSubstrings!.map((x) => x.toJson())),
        "place_id": placeId,
        "reference": reference,
        "structured_formatting": structuredFormatting?.toJson(),
        "terms": terms == null
            ? []
            : List<dynamic>.from(terms!.map((x) => x.toJson())),
        "types": types == null ? [] : List<dynamic>.from(types!.map((x) => x)),
      };
}

class MatchedSubstringGoogle {
  int? length;
  int? offset;

  MatchedSubstringGoogle({
    this.length,
    this.offset,
  });

  MatchedSubstringGoogle copyWith({
    int? length,
    int? offset,
  }) =>
      MatchedSubstringGoogle(
        length: length ?? this.length,
        offset: offset ?? this.offset,
      );

  factory MatchedSubstringGoogle.fromJson(Map<String, dynamic> json) =>
      MatchedSubstringGoogle(
        length: json["length"],
        offset: json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "offset": offset,
      };
}

class StructuredFormattingGoogle {
  String? mainText;
  List<MatchedSubstringGoogle>? mainTextMatchedSubstrings;
  String? secondaryText;

  StructuredFormattingGoogle({
    this.mainText,
    this.mainTextMatchedSubstrings,
    this.secondaryText,
  });

  StructuredFormattingGoogle copyWith({
    String? mainText,
    List<MatchedSubstringGoogle>? mainTextMatchedSubstrings,
    String? secondaryText,
  }) =>
      StructuredFormattingGoogle(
        mainText: mainText ?? this.mainText,
        mainTextMatchedSubstrings:
            mainTextMatchedSubstrings ?? this.mainTextMatchedSubstrings,
        secondaryText: secondaryText ?? this.secondaryText,
      );

  factory StructuredFormattingGoogle.fromJson(Map<String, dynamic> json) =>
      StructuredFormattingGoogle(
        mainText: json["main_text"],
        mainTextMatchedSubstrings: json["main_text_matched_substrings"] == null
            ? []
            : List<MatchedSubstringGoogle>.from(json["main_text_matched_substrings"]!
                .map((x) => MatchedSubstringGoogle.fromJson(x))),
        secondaryText: json["secondary_text"],
      );

  Map<String, dynamic> toJson() => {
        "main_text": mainText,
        "main_text_matched_substrings": mainTextMatchedSubstrings == null
            ? []
            : List<dynamic>.from(
                mainTextMatchedSubstrings!.map((x) => x.toJson())),
        "secondary_text": secondaryText,
      };
}

class TermGoogle {
  int? offset;
  String? value;

  TermGoogle({
    this.offset,
    this.value,
  });

  TermGoogle copyWith({
    int? offset,
    String? value,
  }) =>
      TermGoogle(
        offset: offset ?? this.offset,
        value: value ?? this.value,
      );

  factory TermGoogle.fromJson(Map<String, dynamic> json) => TermGoogle(
        offset: json["offset"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "offset": offset,
        "value": value,
      };
}

class AddressDetails {
  final String formattedAddress;
  final double latitude;
  final double longitude;

  AddressDetails({
    required this.formattedAddress,
    required this.latitude,
    required this.longitude,
  });
}

class PlaceDetailsResponse {
  final PlaceResult? result;
  final String? status;

  PlaceDetailsResponse({this.result, this.status});

  factory PlaceDetailsResponse.fromJson(String jsonString) {
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    return PlaceDetailsResponse(
      result: json['result'] != null
          ? PlaceResult.fromJson(json['result'] as Map<String, dynamic>)
          : null,
      status: json['status'] as String?,
    );
  }
}

class PlaceResult {
  final Geometry? geometry;
  final String? formattedAddress;

  PlaceResult({this.geometry, this.formattedAddress});

  factory PlaceResult.fromJson(Map<String, dynamic> json) {
    return PlaceResult(
      geometry: json['geometry'] != null
          ? Geometry.fromJson(json['geometry'] as Map<String, dynamic>)
          : null,
      formattedAddress: json['formatted_address'] as String?,
    );
  }
}

class Geometry {
  final Location? location;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location: json['location'] != null
          ? Location.fromJson(json['location'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Location {
  final double? lat;
  final double? lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
