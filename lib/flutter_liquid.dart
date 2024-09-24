import 'dart:typed_data';

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

  Future<IdentifyIdChipResult> identifyIdChip() {
    return FlutterLiquidPlatform.instance.identifyIdChip();
  }

  Future<VerifyIdChipResult> verifyIdChip(
      {required String liquidDocumentType,
      required String verificationMethod}) {
    return FlutterLiquidPlatform.instance.verifyIdChip(
        liquidDocumentType: liquidDocumentType,
        verificationMethod: verificationMethod);
  }

  Future<VerifyFaceResult> verifyFace() {
    return FlutterLiquidPlatform.instance.verifyFace();
  }

  Future<void> activate() {
    return FlutterLiquidPlatform.instance.activate();
  }
}

class AdditionalData {
  final String? maintenanceTitle;
  final String? maintenanceMessage;

  AdditionalData({
    required this.maintenanceTitle,
    required this.maintenanceMessage,
  });

  static AdditionalData fromMap(Map<String, dynamic> map) {
    return AdditionalData(
      maintenanceTitle: map['maintenanceTitle'],
      maintenanceMessage: map['maintenanceMessage'],
    );
  }
}

class ProcResult {
  final String status;
  final String resultCode;
  final AdditionalData? additionalData;

  ProcResult({
    required this.status,
    required this.resultCode,
    this.additionalData,
  });

  static ProcResult fromMap(Map<String, dynamic> map) {
    return ProcResult(
      status: map['status'],
      resultCode: map['resultCode'],
      additionalData: map['additionalData'] != null
          ? AdditionalData.fromMap(
              (map['additionalData'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
    );
  }
}

class IdentifyIdChipResult {
  IdentifyIdChipResult({
    required this.result,
    required this.jpkiResult,
    required this.jpkiEvidence,
    this.chipData,
  });

  final ProcResult result;
  final JpkiResult jpkiResult;
  final JpkiEvidence jpkiEvidence;
  final ChipData? chipData;

  static IdentifyIdChipResult fromMap(Map<String, dynamic> map) {
    return IdentifyIdChipResult(
      result: ProcResult.fromMap(
        (map['result'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      jpkiResult: JpkiResult.fromMap(
        (map['jpkiResult'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      jpkiEvidence: JpkiEvidence.fromMap(
        (map['jpkiEvidence'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      chipData: map['chipData'] != null
          ? ChipData.fromMap(
              (map['chipData'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
    );
  }
}

class JpkiResult {
  JpkiResult({
    required this.isSuccess,
  });

  final bool isSuccess;

  static JpkiResult fromMap(Map<String, dynamic> map) {
    return JpkiResult(
      isSuccess: map['isSuccess'],
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

  static JpkiEvidence fromMap(Map<String, dynamic> map) {
    return JpkiEvidence(
      uid: map.containsKey('uid') ? map['uid'] : null,
      asof: map.containsKey('asof') ? map['asof'] : null,
      notBefore: map.containsKey('notBefore') ? map['notBefore'] : null,
      notAfter: map.containsKey('notAfter') ? map['notAfter'] : null,
      issuerDn: map.containsKey('issuerDn') ? map['issuerDn'] : null,
      signatureId: map.containsKey('signatureId') ? map['signatureId'] : null,
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
    this.japaneseForeignerJudgment,
    this.residenceCardComprehensivePermission,
    this.residenceCardIndividualPermission,
    this.residenceCardUpdateStatus,
    this.residenceCardInfoType,
    this.residenceCardType,
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
  final String? sex;
  final String? japaneseForeignerJudgment;
  final String? residenceCardComprehensivePermission;
  final String? residenceCardIndividualPermission;
  final bool? residenceCardUpdateStatus;
  final String? residenceCardInfoType;
  final String? residenceCardType;
  final Uint8List? idFacePhoto;
  final List<Uint8List> nameExternalCharacters;
  final List<Uint8List> previousNameExternalCharacters;
  final List<Uint8List> addressExternalCharacters;
  final bool isExistLatestName;
  final bool isExistLatestAddress;

  static ChipData fromMap(Map<String, dynamic> map) {
    return ChipData(
      name: map.containsKey('name') ? map['name'] : null,
      nameKana: map.containsKey('nameKana') ? map['nameKana'] : null,
      lastNameKanaCandidates: map.containsKey('lastNameKanaCandidates') &&
              map['lastNameKanaCandidates'] != null
          ? List<String>.from(map['lastNameKanaCandidates'])
          : null,
      firstNameKanaCandidates: map.containsKey('firstNameKanaCandidates') &&
              map['firstNameKanaCandidates'] != null
          ? List<String>.from(map['firstNameKanaCandidates'])
          : null,
      previousName:
          map.containsKey('previousName') ? map['previousName'] : null,
      previousLastNameKanaCandidates:
          map.containsKey('previousLastNameKanaCandidates') &&
                  map['previousLastNameKanaCandidates'] != null
              ? List<String>.from(map['previousLastNameKanaCandidates'])
              : null,
      birthday: map.containsKey('birthday') ? map['birthday'] : null,
      address: map.containsKey('address') ? map['address'] : null,
      idNumber: map.containsKey('idNumber') ? map['idNumber'] : null,
      expireDate: map.containsKey('expireDate') ? map['expireDate'] : null,
      myNumber: map.containsKey('myNumber') ? map['myNumber'] : null,
      zipCode: map.containsKey('zipCode') ? map['zipCode'] : null,
      sex: map.containsKey('sex') ? map['sex'] : null,
      japaneseForeignerJudgment: map.containsKey('japaneseForeignerJudgment')
          ? map['japaneseForeignerJudgment']
          : null,
      residenceCardComprehensivePermission:
          map.containsKey('residenceCardComprehensivePermission')
              ? map['residenceCardComprehensivePermission']
              : null,
      residenceCardIndividualPermission:
          map.containsKey('residenceCardIndividualPermission')
              ? map['residenceCardIndividualPermission']
              : null,
      residenceCardUpdateStatus: map.containsKey('residenceCardUpdateStatus')
          ? map['residenceCardUpdateStatus']
          : null,
      residenceCardInfoType: map.containsKey('residenceCardInfoType')
          ? map['residenceCardInfoType']
          : null,
      residenceCardType: map.containsKey('residenceCardType')
          ? map['residenceCardType']
          : null,
      idFacePhoto: map.containsKey('idFacePhoto') ? map['idFacePhoto'] : null,
      nameExternalCharacters: map.containsKey('nameExternalCharacters') &&
              map['nameExternalCharacters'] != null
          ? List<Uint8List>.from(map['nameExternalCharacters'])
          : [],
      previousNameExternalCharacters:
          map.containsKey('previousNameExternalCharacters') &&
                  map['previousNameExternalCharacters'] != null
              ? List<Uint8List>.from(map['previousNameExternalCharacters'])
              : [],
      addressExternalCharacters: map.containsKey('addressExternalCharacters') &&
              map['addressExternalCharacters'] != null
          ? List<Uint8List>.from(map['addressExternalCharacters'])
          : [],
      isExistLatestName: map.containsKey('isExistLatestName')
          ? map['isExistLatestName']
          : false,
      isExistLatestAddress: map.containsKey('isExistLatestAddress')
          ? map['isExistLatestAddress']
          : false,
    );
  }
}

extension MapExtension on Map<String, dynamic> {
  T? getOrNull<T>(String key) {
    if (containsKey(key)) {
      return this[key] as T?;
    }
    return null;
  }
}

class VerifyIdChipResult {
  VerifyIdChipResult({
    required this.result,
    this.autoVerificationFacePhoto,
    this.autoVerificationFace,
    this.autoVerificationFacePassive,
    required this.documentImage,
    required this.chipData,
  });

  final ProcResult result;
  final AutoVerificationFacePhoto? autoVerificationFacePhoto;
  final AutoVerificationFace? autoVerificationFace;
  final AutoVerificationFacePassive? autoVerificationFacePassive;
  final DocumentImage? documentImage;
  final ChipData? chipData;

  static VerifyIdChipResult fromMap(Map<String, dynamic> map) {
    return VerifyIdChipResult(
      result: ProcResult.fromMap(
        (map['result'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      autoVerificationFacePhoto: map['autoVerificationFacePhoto'] != null
          ? AutoVerificationFacePhoto.fromMap(
              (map['autoVerificationFacePhoto'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      autoVerificationFace: map['autoVerificationFace'] != null
          ? AutoVerificationFace.fromMap(
              (map['autoVerificationFace'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      autoVerificationFacePassive: map['autoVerificationFacePassive'] != null
          ? AutoVerificationFacePassive.fromMap(
              (map['autoVerificationFacePassive'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      documentImage: map['documentImage'] != null
          ? DocumentImage.fromMap(
              (map['documentImage'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      chipData: map['chipData'] != null
          ? ChipData.fromMap(
              (map['chipData'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
    );
  }
}

class AutoVerificationFacePhoto {
  AutoVerificationFacePhoto({
    required this.resultType,
    required this.score,
  });

  final int resultType;
  final int score;

  static AutoVerificationFacePhoto fromMap(Map<String, dynamic> map) {
    return AutoVerificationFacePhoto(
      resultType: map.containsKey('resultType') ? map['resultType'] : null,
      score: map.containsKey('score') ? map['score'] : null,
    );
  }
}

class AutoVerificationFace {
  AutoVerificationFace({
    required this.resultType,
    required this.score,
  });

  final int resultType;
  final int score;

  static AutoVerificationFace fromMap(Map<String, dynamic> map) {
    return AutoVerificationFace(
      resultType: map.containsKey('resultType') ? map['resultType'] : null,
      score: map.containsKey('score') ? map['score'] : null,
    );
  }
}

class AutoVerificationFacePassive {
  AutoVerificationFacePassive({required this.result});

  final bool result;

  static AutoVerificationFacePassive fromMap(Map<String, dynamic> map) {
    return AutoVerificationFacePassive(
      result: map.containsKey('result') ? map['result'] : null,
    );
  }
}

class DocumentImage {
  DocumentImage({
    this.front,
    this.diagonal,
    this.back,
  });

  final Uint8List? front;
  final Uint8List? diagonal;
  final Uint8List? back;

  static DocumentImage fromMap(Map<String, dynamic> map) {
    return DocumentImage(
      front: map.containsKey('front') ? map['front'] : null,
      diagonal: map.containsKey('diagonal') ? map['diagonal'] : null,
      back: map.containsKey('back') ? map['back'] : null,
    );
  }
}

class VerifyFaceResult {
  VerifyFaceResult({
    required this.result,
    this.autoVerificationFacePhoto,
    this.autoVerificationFace,
    this.autoVerificationFacePassive,
    this.faceImage,
  });

  final ProcResult result;
  final AutoVerificationFacePhoto? autoVerificationFacePhoto;
  final AutoVerificationFace? autoVerificationFace;
  final AutoVerificationFacePassive? autoVerificationFacePassive;
  final FaceImage? faceImage;

  static VerifyFaceResult fromMap(Map<String, dynamic> map) {
    return VerifyFaceResult(
      result: ProcResult.fromMap(
        (map['result'] as Map<dynamic, dynamic>).cast<String, dynamic>(),
      ),
      autoVerificationFacePhoto: map['autoVerificationFacePhoto'] != null
          ? AutoVerificationFacePhoto.fromMap(
              (map['autoVerificationFacePhoto'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      autoVerificationFace: map['autoVerificationFace'] != null
          ? AutoVerificationFace.fromMap(
              (map['autoVerificationFace'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      autoVerificationFacePassive: map['autoVerificationFacePassive'] != null
          ? AutoVerificationFacePassive.fromMap(
              (map['autoVerificationFacePassive'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
      faceImage: map['faceImage'] != null
          ? FaceImage.fromMap(
              (map['faceImage'] as Map<dynamic, dynamic>)
                  .cast<String, dynamic>(),
            )
          : null,
    );
  }
}

class FaceImage {
  FaceImage({
    required this.faceFront,
    required this.liveness,
  });

  final Uint8List faceFront;
  final List<Uint8List> liveness;

  static FaceImage fromMap(Map<String, dynamic> map) {
    return FaceImage(
      faceFront: map.containsKey('faceFront') ? map['faceFront'] : null,
      liveness: (map['liveness'] as List<dynamic>).cast<Uint8List>(),
    );
  }
}
