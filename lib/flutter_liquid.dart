import 'flutter_liquid_platform_interface.dart';

class FlutterLiquid {
  Future<String> getVersion() {
    return FlutterLiquidPlatform.instance.getVersion();
  }

  Future<String?> startVerify({
    required String endpoint,
    required String apiKey,
    String? token,
    String? applicant,
  }) {
    return FlutterLiquidPlatform.instance.startVerify(
      endpoint: endpoint,
      apiKey: apiKey,
      token: token,
      applicant: applicant,
    );
  }

  Future<IdentifyIdChipResult> identifyIdChip({
    required int documentTypeJpki,
    required int verificationMethodJpki,
    String? base64TargetData,
    bool? enabledChipForgotPin,
  }) {
    return FlutterLiquidPlatform.instance.identifyIdChip(
      documentTypeJpki: documentTypeJpki,
      verificationMethodJpki: verificationMethodJpki,
      base64TargetData: base64TargetData,
      enabledChipForgotPin: enabledChipForgotPin,
    );
  }

  Future<void> activate() {
    return FlutterLiquidPlatform.instance.activate();
  }
}

class IdentifyIdChipResult {
  IdentifyIdChipResult({
    required this.jpkiResult,
    required this.jpkiEvidence,
    this.chipData,
  });

  final JpkiResult jpkiResult;
  final JpkiEvidence jpkiEvidence;
  final ChipData? chipData;

  static IdentifyIdChipResult fromJson(Map<String, dynamic> json) {
    return IdentifyIdChipResult(
      jpkiResult: JpkiResult.fromJson(json['jpkiResult']),
      jpkiEvidence: JpkiEvidence.fromJson(json['jpkiEvidence']),
      chipData:
          json['chipData'] != null ? ChipData.fromJson(json['chipData']) : null,
    );
  }
}

class JpkiResult {
  JpkiResult({
    required this.isSuccess,
  });

  final bool isSuccess;

  static JpkiResult fromJson(Map<String, dynamic> json) {
    return JpkiResult(
      isSuccess: json['isSuccess'],
    );
  }
}

class JpkiEvidence {
  JpkiEvidence({
    this.uid,
    this.asof,
    this.notBefore,
    this.notAfter,
    this.issuerDn,
    this.signatureId,
  });

  final String? uid;
  final String? asof;
  final String? notBefore;
  final String? notAfter;
  final String? issuerDn;
  final String? signatureId;

  static JpkiEvidence fromJson(Map<String, dynamic> json) {
    return JpkiEvidence(
      uid: json['uid'],
      asof: json['asof'],
      notBefore: json['notBefore'],
      notAfter: json['notAfter'],
      issuerDn: json['issuerDn'],
      signatureId: json['signatureId'],
    );
  }
}

class ChipData {
  ChipData({
    this.name,
    this.nameKana,
    this.lastNameKanaCandidates,
    this.firstNameKanaCandidates,
    this.previousName,
    this.previousLastNameKanaCandidates,
    this.birthday,
    this.address,
    this.idNumber,
    this.expireDate,
    this.myNumber,
    this.zipCode,
    this.sex,
    required this.sexValue,
    required this.sexValueIsValid,
    this.japaneseForeignerJudgment,
    this.residenceCardComprehensivePermission,
    this.residenceCardIndividualPermission,
    this.residenceCardUpdateStatus,
    required this.residenceCardUpdateStatusValue,
    required this.residenceCardUpdateStatusValueIsValid,
    this.residenceCardInfoType,
    required this.residenceCardInfoTypeValue,
    required this.residenceCardInfoTypeValueIsValid,
    this.residenceCardType,
    required this.residenceCardTypeValue,
    required this.residenceCardTypeValueIsValid,
    this.idFacePhoto,
    this.nameExternalCharacters = const [],
    this.previousNameExternalCharacters = const [],
    this.addressExternalCharacters = const [],
    required this.isExistLatestName,
    required this.isExistLatestAddress,
  });

  final String? name;
  final String? nameKana;
  final List<String>? lastNameKanaCandidates;
  final List<String>? firstNameKanaCandidates;
  final String? previousName;
  final List<String>? previousLastNameKanaCandidates;
  final String? birthday;
  final String? address;
  final String? idNumber;
  final String? expireDate;
  final String? myNumber;
  final String? zipCode;
  final int? sex;
  final int sexValue;
  final bool sexValueIsValid;
  final int? japaneseForeignerJudgment;
  final String? residenceCardComprehensivePermission;
  final String? residenceCardIndividualPermission;
  final bool? residenceCardUpdateStatus;
  final bool residenceCardUpdateStatusValue;
  final bool residenceCardUpdateStatusValueIsValid;
  final int? residenceCardInfoType;
  final int residenceCardInfoTypeValue;
  final bool residenceCardInfoTypeValueIsValid;
  final int? residenceCardType;
  final int residenceCardTypeValue;
  final bool residenceCardTypeValueIsValid;
  final String? idFacePhoto;
  final List<String> nameExternalCharacters;
  final List<String> previousNameExternalCharacters;
  final List<String> addressExternalCharacters;
  final bool isExistLatestName;
  final bool isExistLatestAddress;

  static ChipData fromJson(Map<String, dynamic> json) {
    return ChipData(
      name: json['name'],
      nameKana: json['nameKana'],
      lastNameKanaCandidates: List<String>.from(json['lastNameKanaCandidates']),
      firstNameKanaCandidates:
          List<String>.from(json['firstNameKanaCandidates']),
      previousName: json['previousName'],
      previousLastNameKanaCandidates:
          List<String>.from(json['previousLastNameKanaCandidates']),
      birthday: json['birthday'],
      address: json['address'],
      idNumber: json['idNumber'],
      expireDate: json['expireDate'],
      myNumber: json['myNumber'],
      zipCode: json['zipCode'],
      sex: json['sex'],
      sexValue: json['sexValue'],
      sexValueIsValid: json['sexValueIsValid'],
      japaneseForeignerJudgment: json['japaneseForeignerJudgment'],
      residenceCardComprehensivePermission:
          json['residenceCardComprehensivePermission'],
      residenceCardIndividualPermission:
          json['residenceCardIndividualPermission'],
      residenceCardUpdateStatus: json['residenceCardUpdateStatus'],
      residenceCardUpdateStatusValue: json['residenceCardUpdateStatusValue'],
      residenceCardUpdateStatusValueIsValid:
          json['residenceCardUpdateStatusValueIsValid'],
      residenceCardInfoType: json['residenceCardInfoType'],
      residenceCardInfoTypeValue: json['residenceCardInfoTypeValue'],
      residenceCardInfoTypeValueIsValid:
          json['residenceCardInfoTypeValueIsValid'],
      residenceCardType: json['residenceCardType'],
      residenceCardTypeValue: json['residenceCardTypeValue'],
      residenceCardTypeValueIsValid: json['residenceCardTypeValueIsValid'],
      idFacePhoto: json['idFacePhoto'],
      nameExternalCharacters: List<String>.from(json['nameExternalCharacters']),
      previousNameExternalCharacters: json['previousNameExternalCharacters'],
      addressExternalCharacters: json['addressExternalCharacters'],
      isExistLatestName: json['isExistLatestName'],
      isExistLatestAddress: json['isExistLatestAddress'],
    );
  }
}
