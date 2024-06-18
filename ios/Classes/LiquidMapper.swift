import Liquid

extension ResultStatus {
  func toString() -> String {
    switch (self) {
    case .success:
      return "SUCCESS"
    case .maintenance:
      return "MAINTENANCE"
    case .permissionNotAllowed:
      return "PERMISSION_NOT_ALLOWED"
    case .screenTimeout:
      return "SCREEN_TIMEOUT"
    case .sessionTimeout:
      return "SESSION_TIMEOUT"
    case .ocrInProgress:
      return "OCR_IN_PROGRESS"
    case .ocrUnSupported:
      return "OCR_UNSUPPORTED"
    case .userCancel:
      return "USER_CANCEL"
    case .error:
      return "ERROR"
    case .chipLocked:
      return "CHIP_LOCKED"
    case .chipUnusual:
      return "CHIP_UNUSUAL"
    case .chipUnusualUpdated:
      return "CHIP_UNUSUAL_UPDATED"
    case .chipVerifyFailure:
      return "CHIP_VERIFY_FAILURE"
    case .chipUnusualResidencecard:
      return "CHIP_UNUSUAL_RESIDENCECARD"
    case .chipMissingExternalChar:
      return "CHIP_MISSING_EXTERNAL_CHAR"
    case .unsupportedChip:
      return "UNSUPPORTED_CHIP"
    case .chipPinFailure:
      return "CHIP_PIN_FAILURE"
    case .chipExpired:
      return "CHIP_EXPIRED"
    case .chipForgotPin:
      return "CHIP_FORGOT_PIN"
    case .chipIdentifyDenied:
      return "CHIP_IDENTIFY_DENIED"
    case .chipIdentifyError:
      return "CHIP_IDENTIFY_ERROR"
    case .termsDoNotAgree:
      return "TERMS_DO_NOT_AGREE"
    case .communicationFailure:
      return "COMMUNICATION_FAILURE"
    @unknown default:
      fatalError()
    }
  }
}

extension ProcResult {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "status": status.toString(),
      "resultCode": resultCode,
      "additionalData": additionalData?.toDictionary(),
    ]
  }
}

extension AdditionalData {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "maintenanceTitle": maintenanceTitle,
      "maintenanceMessage": maintenanceMessage,
    ]
  }
}

extension JpkiResult {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "isSuccess": isSuccess,
    ]
  }
}

extension JpkiEvidence {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "uid": uid,
      "asof": asof,
      "notBefore": notBefore,
      "notAfter": notAfter,
      "issuerDn": issuerDn,
      "signatureId": signatureId,
    ]
  }
}

extension Sex {
  func toString() -> String {
    switch (self) {
    case .male:
      return "MALE"
    case .female:
      return "FEMALE"
    case .others:
      return "OTHERS"
    @unknown default:
      fatalError()
    }
  }
}

extension ResidenceCardInfoType {
  func toString() -> String {
    switch (self) {
    case .noCertificate:
      return "NO_CERTIFICATE"
    case .normal:
      return "NORMAL"
    case .under_16:
      return "UNDER_16"
    @unknown default:
      fatalError()
    }
  }
}

extension ResidenceCardType {
  func toString() -> String {
    switch (self) {
    case .residenceCard:
      return "RESIDENCE_CARD"
    case .specialPermanentResidentCertificate:
      return "SPECIAL_PERMANENT_RESIDENT_CERTIFICATE"
    case .undetected:
      return "UNDETECTED"
    @unknown default:
      fatalError()
    }
  }
}

extension ChipData {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "name": name,
      "nameKana": nameKana,
      "lastNameKanaCandidates": lastNameKanaCandidates,
      "firstNameKanaCandidates": firstNameKanaCandidates,
      "previousName": previousName,
      "previousLastNameKanaCandidates": previousLastNameKanaCandidates,
      "birthday": birthday,
      "address": address,
      "idNumber": idNumber,
      "expireDate": expireDate,
      "myNumber": myNumber,
      "zipCode": zipCode,
      "sex": sex?.toString(),
      "japaneseForeignerJudgment": japaneseForeignerJudgment?.description,
      "residenceCardComprehensivePermission": residenceCardComprehensivePermission,
      "residenceCardIndividualPermission": residenceCardIndividualPermission,
      "residenceCardUpdateStatus": residenceCardUpdateStatus,
      "residenceCardInfoType": residenceCardInfoType?.toString(),
      "residenceCardType": residenceCardType?.toString(),
      "idFacePhoto": idFacePhoto?.jpegData(compressionQuality: 1.0)?.base64EncodedString(),
      "nameExternalCharacters": nameExternalCharacters.map {
        $0.jpegData(compressionQuality: 1.0)?.base64EncodedString()
      },
      "previousNameExternalCharacters": previousNameExternalCharacters.map {
        $0.jpegData(compressionQuality: 1.0)?.base64EncodedString()
      },
      "addressExternalCharacters": addressExternalCharacters.map {
        $0.jpegData(compressionQuality: 1.0)?.base64EncodedString()
      },
      "isExistLatestName": isExistLatestName,
      "isExistLatestAddress": isExistLatestAddress,
    ]
  }
}

extension IdentifyIdChipResult {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "result": result.toDictionary(),
      "chipData": chipData?.toDictionary(),
      "jpkiResult": jpkiResult.toDictionary(),
      "jpkiEvidence": jpkiEvidence.toDictionary(),
    ]
  }
}
