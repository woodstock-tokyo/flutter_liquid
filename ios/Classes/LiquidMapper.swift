import Liquid
import Flutter

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
      var idFacePhotoData:FlutterStandardTypedData?
      let idFacePhotoJpegData = idFacePhoto?.jpegData(compressionQuality: 100)
      if  idFacePhotoJpegData != nil {
          idFacePhotoData = FlutterStandardTypedData(bytes: idFacePhotoJpegData!)
      }
      
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
      "idFacePhoto": idFacePhotoData,
      "nameExternalCharacters": nameExternalCharacters.map { t-> FlutterStandardTypedData? in
          let jpegData = t.jpegData(compressionQuality: 1.0)
          if (jpegData == nil) {
              return nil
          }
          return FlutterStandardTypedData(bytes: jpegData!)
      },
      "previousNameExternalCharacters": previousNameExternalCharacters.map { t-> FlutterStandardTypedData? in
          let jpegData = t.jpegData(compressionQuality: 1.0)
          if (jpegData == nil) {
              return nil
          }
          return FlutterStandardTypedData(bytes: jpegData!)
      },
      "addressExternalCharacters": addressExternalCharacters.map { t-> FlutterStandardTypedData? in
          let jpegData = t.jpegData(compressionQuality: 1.0)
          if (jpegData == nil) {
              return nil
          }
          return FlutterStandardTypedData(bytes: jpegData!)
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


extension VerifyIdChipResult {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "result": result.toDictionary(),
      "autoVerificationFacePhoto": facePhotoVerification?.toDictionary(),
      "autoVerificationFace": faceVerification?.toDictionary(),
      "autoVerificationFacePassive": faceVerificationPassive?.toDictionary(),
      "documentImage": documentImage?.toDictionary(),
      "chipData": chipData?.toDictionary(),
    ]
  }
}

extension FacePhotoVerification{
    func toDictionary() -> Dictionary<String, Any?> {
      return [
        "resultType": result.rawValue,
        "score": score,
      ]
    }
}

extension FaceVerification{
    func toDictionary() -> Dictionary<String, Any?> {
      return [
        "resultType": result.rawValue,
        "score": score,
      ]
    }
}

extension FaceVerificationPassive{
    func toDictionary() -> Dictionary<String, Any?> {
      return [
        "result": result,
      ]
    }
}

extension VerifyFaceResult {
  func toDictionary() -> Dictionary<String, Any?> {
    return [
      "result": result.toDictionary(),
      "autoVerificationFacePhoto" : facePhotoVerification?.toDictionary(),
      "autoVerificationFace" : faceVerification?.toDictionary(),
      "autoVerificationFacePassive" : faceVerificationPassive?.toDictionary(),
      "faceImage" : faceImage?.toDictionary(),
    ]
  }
}

extension FaceImage{
    func toDictionary() -> Dictionary<String, Any?> {
        var faceFrontData:FlutterStandardTypedData?
        let jpegData = faceFront.jpegData(compressionQuality: 100)
        if  jpegData != nil {
            faceFrontData = FlutterStandardTypedData(bytes: jpegData!)
        }
        
        var livenessData: Array<FlutterStandardTypedData> = []
        let jpegData1 = liveness.pattern1.jpegData(compressionQuality: 100)
        if  jpegData1 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData1!))
        }
        let jpegData2 = liveness.pattern2.jpegData(compressionQuality: 100)
        if  jpegData2 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData2!))
        }
        let jpegData3 = liveness.pattern3.jpegData(compressionQuality: 100)
        if  jpegData3 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData3!))
        }
        let jpegData4 = liveness.pattern4.jpegData(compressionQuality: 100)
        if  jpegData4 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData4!))
        }
        let jpegData5 = liveness.pattern5.jpegData(compressionQuality: 100)
        if  jpegData5 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData5!))
        }
        let jpegData6 = liveness.pattern6.jpegData(compressionQuality: 100)
        if  jpegData6 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData6!))
        }
        let jpegData7 = liveness.pattern7.jpegData(compressionQuality: 100)
        if  jpegData7 != nil {
            livenessData.append(FlutterStandardTypedData(bytes: jpegData7!))
        }
        
      return [
        "faceFront": faceFrontData,
        "liveness": livenessData,
      ]
    }
}

extension DocumentImage{
    func toDictionary() -> Dictionary<String, Any?> {
        var frontData:FlutterStandardTypedData?
        let frontJpegData = front.jpegData(compressionQuality: 100)
        if  frontJpegData != nil {
            frontData = FlutterStandardTypedData(bytes: frontJpegData!)
        }
        var diagonalData:FlutterStandardTypedData?
        let diagonalJpegData = diagonalOrNil?.jpegData(compressionQuality: 100)
        if  diagonalJpegData != nil {
            diagonalData = FlutterStandardTypedData(bytes: diagonalJpegData!)
        }
        var backData:FlutterStandardTypedData?
        let backJpegData = backOrNil?.jpegData(compressionQuality: 100)
        if  backJpegData != nil {
            backData = FlutterStandardTypedData(bytes: backJpegData!)
        }
        
      return [
        "front": frontData,
        "diagonal": diagonalData,
        "back": backData,
      ]
    }
}

extension IdDocumentType {
    static func fromString(_ str:String) -> IdDocumentType? {
        switch str {
        case "DRIVER_LICENSE":
            return IdDocumentType.driverLicence
        case "MY_NUMBER_CARD":
            return IdDocumentType.mynumberCard
        case "RESIDENCE_CARD":
            return IdDocumentType.residenceCard
        case "DRIVING_HISTORY_CARD":
            return IdDocumentType.driverLicenseHistory
        case "PASSPORT":
            return IdDocumentType.passport
        case "PASSPORT_ALL_PERIODS":
            return IdDocumentType.passportAllPeriods
        case "HEALTH_INSURANCE_CARD":
            return IdDocumentType.healthInsuranceCard
        case "PHYSICAL_DISABILITY_CERTIFICATE_CARD":
            return IdDocumentType.physicalDisabilityCertificateCard
        case "SPECIAL_EDUCATION_CARD":
            return IdDocumentType.specialEducationCard
        case "MENTAL_DISABILITY_CERTIFICATE_CARD":
            return IdDocumentType.mentalDisabilityCertificateCard
        case "BASIC_RESIDENT_REGISTRATION_CARD":
            return IdDocumentType.basicResidentRegistrationCard
        case "STUDENT_ID_CARD":
            return IdDocumentType.studentIdCard
        case "PHYSICAL_DISABILITY_CERTIFICATE_BOOK":
            return IdDocumentType.physicalDisabilityCertificateBook
        case "SPECIAL_EDUCATION_BOOK":
            return IdDocumentType.specialEducationBook
        case "MENTAL_DISABILITY_CERTIFICATE_BOOK":
            return IdDocumentType.mentalDisabilityCertificateBook
        case "PENSION_BOOK":
            return IdDocumentType.pensionBook
        case "BASIC_PENSION_NUMBER_NOTIFICATION":
            return IdDocumentType.basicPensionNumberNotification
        case "STUDENT_NOTEBOOK":
            return IdDocumentType.studentNotebook
        case "EMPLOYEE_ID_CARD":
            return IdDocumentType.employeeIdCard
        case "SPECIAL_PERMANENT_RESIDENT_CERTIFICATE":
            return IdDocumentType.specialPermanentResidentCertificate
        case "MY_NUMBER_CARD_WITH_MY_NUMBER":
            return IdDocumentType.mynumberCardWithMyNumber
        default:
            return nil
        }
  }
    
    func toString() -> String {
        switch self {
        case .driverLicence:
            return "DRIVER_LICENSE"
        case .mynumberCard:
            return "MY_NUMBER_CARD"
        case .residenceCard:
            return "RESIDENCE_CARD"
        case .passport:
            return "PASSPORT"
        case .specialPermanentResidentCertificate:
            return "SPECIAL_PERMANENT_RESIDENT_CERTIFICATE"
        case .driverLicenseHistory:
            return "DRIVING_HISTORY_CARD"
        case .healthInsuranceCard:
            return "HEALTH_INSURANCE_CARD"
        case .physicalDisabilityCertificateBook:
            return "PHYSICAL_DISABILITY_CERTIFICATE_BOOK"
        case .physicalDisabilityCertificateCard:
            return "PHYSICAL_DISABILITY_CERTIFICATE_CARD"
        case .specialEducationBook:
            return "SPECIAL_EDUCATION_BOOK"
        case .specialEducationCard:
            return "SPECIAL_EDUCATION_CARD"
        case .mentalDisabilityCertificateBook:
            return "MENTAL_DISABILITY_CERTIFICATE_BOOK"
        case .mentalDisabilityCertificateCard:
            return "MENTAL_DISABILITY_CERTIFICATE_CARD"
        case .pensionBook:
            return "PENSION_BOOK"
        case .basicPensionNumberNotification:
            return "BASIC_PENSION_NUMBER_NOTIFICATION"
        case .passportAllPeriods:
            return "PASSPORT_ALL_PERIODS"
        case .basicResidentRegistrationCard:
            return "BASIC_RESIDENT_REGISTRATION_CARD"
        case .studentIdCard:
            return "STUDENT_ID_CARD"
        case .studentNotebook:
            return "STUDENT_NOTEBOOK"
        case .employeeIdCard:
            return "EMPLOYEE_ID_CARD"
        case .mynumberCardWithMyNumber:
            return "MY_NUMBER_CARD_WITH_MY_NUMBER"
        @unknown default:
            fatalError()
        }
  }
}


extension VerificationMethod {
    static func fromString(_ str:String) -> VerificationMethod? {
        switch str {
        case "COMPLY_HE":
            return VerificationMethod.complyHe
        case "READ_FACE":
            return VerificationMethod.readFace
        case "COMPLY_TO":
            return VerificationMethod.complyTo
        case "COMPLY_CHI":
            return VerificationMethod.complyChi
        case "READ":
            return VerificationMethod.read
        case "COMPLY_HO":
            return VerificationMethod.complyHo
        case "FRONT_FACE":
            return VerificationMethod.frontFace
        case "FRONT":
            return VerificationMethod.front
        case "FRONT_BACK_FACE":
            return VerificationMethod.frontBackFace
        case "FRONT_BACK":
            return VerificationMethod.frontBack
        default:
            return nil
        }
  }
    
    func toString() -> String {
        switch self {
        case .complyHe:
            return "COMPLY_HE"
        case .readFace:
            return "READ_FACE"
        case .complyTo:
            return "COMPLY_TO"
        case .complyChi:
            return "COMPLY_CHI"
        case .read:
            return "READ"
        case .complyHo:
            return  "COMPLY_HO"
        case .frontFace:
            return  "FRONT_FACE"
        case .front:
            return "FRONT"
        case .frontBackFace:
            return "FRONT_BACK_FACE"
        case .frontBack:
            return "FRONT_BACK"
        @unknown default:
            fatalError()
        }
        
  }
}
