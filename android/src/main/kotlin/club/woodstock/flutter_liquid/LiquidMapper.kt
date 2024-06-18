package club.woodstock.flutter_liquid

import asia.liquidinc.ekyc.applicant.external.result.LiquidChipIdentificationResult
import asia.liquidinc.ekyc.applicant.external.result.LiquidProcessingResult
import asia.liquidinc.ekyc.applicant.external.result.chip.LiquidChipData
import asia.liquidinc.ekyc.applicant.external.result.jpki.JpkiEvidence
import asia.liquidinc.ekyc.applicant.external.result.jpki.JpkiResult

fun JpkiResult.toMap(): Map<String, Any?> {
    return mapOf(
        "isSuccess" to isSuccess,
    )
}

fun JpkiEvidence.toMap(): Map<String, Any?> {
    return mapOf(
        "uid" to uid,
        "asof" to asOf,
        "notBefore" to notBefore,
        "notAfter" to notAfter,
        "issuerDn" to issuerDn,
        "signatureId" to signatureId,
    )
}

fun LiquidChipData.toMap(): Map<String, Any?> {
    return mapOf(
        "name" to name,
        "nameKana" to nameKana,
        "lastNameKanaCandidates" to lastNameKanaCandidates,
        "firstNameKanaCandidates" to firstNameKanaCandidates,
        "previousName" to previousName,
        "previousLastNameKanaCandidates" to previousLastNameKanaCandidates,
        "birthday" to birthday,
        "address" to address,
        "idNumber" to idNumber,
        "expireDate" to expireDate,
        "myNumber" to myNumber,
        "zipCode" to zipCode,
        "sex" to sex.name,
        "japaneseForeignerJudgment" to japaneseForeignerJudgment?.name,
        "residenceCardComprehensivePermission" to residenceCardComprehensivePermission,
        "residenceCardIndividualPermission" to residenceCardIndividualPermission,
        "residenceCardUpdateStatus" to isResidenceCardUpdateStatus,
        "residenceCardInfoType" to liquidResidenceCardInfoType?.name,
        "residenceCardType" to liquidResidenceCardType?.name,
        "idFacePhoto" to idFacePhoto,
        "nameExternalCharacters" to nameExternalCharacters,
        "previousNameExternalCharacters" to previousNameExternalCharacters,
        "addressExternalCharacters" to addressExternalCharacters,
        "isExistLatestName" to isExistLatestName,
        "isExistLatestAddress" to isExistLatestAddress,
    )
}

fun LiquidChipIdentificationResult.toMap(): Map<String, Any?> {
    return mapOf(
        "result" to mapOf(
            "status" to resultStatus.name,
            "resultCode" to errorCode,
            "additionalData" to mapOf(
                "maintenanceTitle" to additionalDataTitle,
                "maintenanceMessage" to additionalDataMessage,
            ),
        ),
        "chipData" to liquidChipData?.toMap(),
        "jpkiResult" to jpkiResult?.toMap(),
        "jpkiEvidence" to jpkiEvidence?.toMap(),
    )
}

fun LiquidProcessingResult.toMap(): Map<String, Any?> {
    return mapOf(
        "status" to this.result.name,
        "resultCode" to errorCode,
        "additionalData" to mapOf(
            "maintenanceTitle" to additionalDataTitle,
            "maintenanceMessage" to additionalDataMessage,
        ),
    )
}