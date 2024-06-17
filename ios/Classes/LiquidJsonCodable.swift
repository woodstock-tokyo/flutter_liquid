import Liquid

struct LiquidAdditionalData: Codable {
  let maintenanceTitle: String
  let maintenanceMessage: String
  
  init(from original: AdditionalData) {
    self.maintenanceTitle = original.maintenanceTitle
    self.maintenanceMessage = original.maintenanceMessage
  }
}

enum LiquidResultStatus: String, Codable {
  /// 正常時 "success"
  case success = "success"
  /// サーバーメンテナンス時 "maintenance"
  case maintenance = "maintenance"
  /// パーミッション不足 "permission_not_allowed"
  case permissionNotAllowed = "permission_not_allowed"
  /// 画面タイムアウト "screen_timeout"
  case screenTimeout = "screen_timeout"
  /// セッションタイムアウト "session_timeout"
  case sessionTimeout = "session_timeout"
  /// OCR未完了 "ocr_in_progress"
  case ocrInProgress = "ocr_in_progress"
  /// OCR利用不可 "ocr_unsupported"
  case ocrUnSupported = "ocr_unsupported"
  /// ユーザー中断 "user_cancel"
  case userCancel = "user_cancel"
  /// エラー終了 "error"
  case error = "error"
  /// ICチップがロック状態 "chip_locked"
  case chipLocked = "chip_locked"
  /// ICチップが特殊 "chip_unusual"
  case chipUnusual = "chip_unusual"
  /// ICチップが特殊（更新情報あり） "chip_unusual_updated"
  case chipUnusualUpdated = "chip_unusual_updated"
  /// ICチップの電子署名の検証に失敗 "chip_verify_failure"
  case chipVerifyFailure = "chip_verify_failure"
  /// ICチップが特殊（在留カード／特別永住者証明書） "chip_unusual_residencecard"
  case chipUnusualResidencecard = "chip_unusual_residencecard"
  /// ICチップの外字画像が欠字 "chip_missing_external_char"
  case chipMissingExternalChar = "chip_missing_external_char"
  /// 非対応端末(ICチップ理由) "unsupported_chip"
  case unsupportedChip = "unsupported_chip"
  /// ICチップ(ただし在留カード／特別永住者証明書)でPIN間違い許容回数超過 "chip_pin_failure"
  case chipPinFailure = "chip_pin_failure"
  /// ICチップが有効期限切れ "chip_expired"
  case chipExpired = "chip_expired"
  /// ICチップの暗証番号失念 "chip_forgot_pin"
  case chipForgotPin = "chip_forgot_pin"
  /// 公的個人認証が否認 "chip_identify_denied"
  case chipIdentifyDenied = "chip_identify_denied"
  /// 公的個人認証がエラー終了 "chip_identify_error"
  case chipIdentifyError = "chip_identify_error"
  /// 利用規約未同意 "terms_do_not_agree"
  case termsDoNotAgree = "terms_do_not_agree"
  /// 通信失敗 "communication_failure"
  case communicationFailure = "communication_failure"

  init(from original: ResultStatus)  {
    switch (original) {
    case .success:
      self = .success
    case .maintenance:
      self = .maintenance
    case .permissionNotAllowed:
      self = .permissionNotAllowed
    case .screenTimeout:
      self = .screenTimeout
    case .sessionTimeout:
      self = .sessionTimeout
    case .ocrInProgress:
      self = .ocrInProgress
    case .ocrUnSupported:
      self = .ocrUnSupported
    case .userCancel:
      self = .userCancel
    case .error:
      self = .error
    case .chipLocked:
      self = .chipLocked
    case .chipUnusual:
      self = .chipUnusual
    case .chipUnusualUpdated:
      self = .chipUnusualUpdated
    case .chipVerifyFailure:
      self = .chipVerifyFailure
    case .chipUnusualResidencecard:
      self = .chipUnusualResidencecard
    case .chipMissingExternalChar:
      self = .chipMissingExternalChar
    case .unsupportedChip:
      self = .unsupportedChip
    case .chipPinFailure:
      self = .chipPinFailure
    case .chipExpired:
      self = .chipExpired
    case .chipForgotPin:
      self = .chipForgotPin
    case .chipIdentifyDenied:
      self = .chipIdentifyDenied
    case .chipIdentifyError:
      self = .chipIdentifyError
    case .termsDoNotAgree:
      self = .termsDoNotAgree
    case .communicationFailure:
      self = .communicationFailure
    @unknown default:
      fatalError()
    }
  }
}

struct LiquidProcResult: Codable {
  let status: LiquidResultStatus
  let resultCode: String
  let additionalData: LiquidAdditionalData?
    
  init(from original: ProcResult) {
    self.status = LiquidResultStatus(from: original.status)
    self.resultCode = original.resultCode
    self.additionalData = original.additionalData != nil ? LiquidAdditionalData(from: original.additionalData!) : nil
  }
}


enum LiquidSex: Int, Codable {
  case male
  case female
  case others
  
  init(from original: Sex) throws {
    switch (original) {
    case .female:
      self = .female
    case .male:
      self = .male
    case .others:
      self = .others
    @unknown default:
      fatalError()
    }
  }
}

struct LiquidChipData: Codable {
  var name: String?
  var nameKana: String?
  var lastNameKanaCandidates: [String]?
  var firstNameKanaCandidates: [String]?
  var previousName: String?
  var previousLastNameKanaCandidates: [String]?
  var birthday: String?
  var address: String?
  var idNumber: String?
  var expireDate: String?
  var myNumber: String?
  var zipCode: String?
  var sex: LiquidSex?
  var residenceCardComprehensivePermission: String?
  var residenceCardIndividualPermission: String?
  var residenceCardUpdateStatus: Bool?
  var isExistLatestName: Bool
  var isExistLatestAddress: Bool

  init(from original: ChipData) {
    self.name = original.name
    self.nameKana = original.nameKana
    self.lastNameKanaCandidates = original.lastNameKanaCandidates
    self.firstNameKanaCandidates = original.firstNameKanaCandidates
    self.previousName = original.previousName
    self.previousLastNameKanaCandidates = original.previousLastNameKanaCandidates
    self.birthday = original.birthday
    self.address = original.address
    self.idNumber = original.idNumber
    self.expireDate = original.expireDate
    self.myNumber = original.myNumber
    self.zipCode = original.zipCode
    self.sex = original.sex != nil ? LiquidSex(rawValue: original.sex!.rawValue) : nil
    self.residenceCardComprehensivePermission = original.residenceCardComprehensivePermission
    self.residenceCardIndividualPermission = original.residenceCardIndividualPermission
    self.residenceCardUpdateStatus = original.residenceCardUpdateStatus
    self.isExistLatestName = original.isExistLatestName
    self.isExistLatestAddress = original.isExistLatestAddress
  }
}

struct LiquidJpkiResult: Codable {
  let isSuccess: Bool
  
  init(from original: JpkiResult) {
    self.isSuccess = original.isSuccess
  }
}

/// 公的個人認証証跡
struct LiquidJpkiEvidence: Codable {
  /// iTrust本人確認対象利用者識別番号
  let uid: String?
  /// 確認時刻
  let asof: String?
  /// 有効期間(開始)
  let notBefore: String?
  /// 有効期間(終了)
  let notAfter: String?
  /// 発行主体
  let issuerDn: String?
  /// 電子署名識別子
  let signatureId: String?
  
  init(from original: JpkiEvidence) {
    self.uid = original.uid
    self.asof = original.asof
    self.notBefore = original.notBefore
    self.notAfter = original.notAfter
    self.issuerDn = original.issuerDn
    self.signatureId = original.signatureId
  }
}


struct LiquidIdentifyIdChipResult: Codable {
  /// 処理結果
  let result: LiquidProcResult
  /// 公的個人認証結果
  let jpkiResult: LiquidJpkiResult
  /// 公的個人認証証跡
  let jpkiEvidence: LiquidJpkiEvidence
  /// ICカード読取情報
  let chipData: LiquidChipData?

  init(from original: IdentifyIdChipResult) {
    self.result = LiquidProcResult(from: original.result)
    self.jpkiResult = LiquidJpkiResult(from: original.jpkiResult)
    self.jpkiEvidence = LiquidJpkiEvidence(from: original.jpkiEvidence)
    self.chipData = original.chipData != nil ? LiquidChipData(from: original.chipData!) : nil
  }
}
