package club.woodstock.flutter_liquid

import android.R.attr.bitmap
import asia.liquidinc.ekyc.applicant.external.result.LiquidChipIdentificationResult
import asia.liquidinc.ekyc.applicant.external.result.LiquidChipVerificationResult
import asia.liquidinc.ekyc.applicant.external.result.LiquidFaceVerificationResult
import asia.liquidinc.ekyc.applicant.external.result.LiquidProcessingResult
import asia.liquidinc.ekyc.applicant.external.result.auto.AutoVerificationFace
import asia.liquidinc.ekyc.applicant.external.result.auto.AutoVerificationFacePassive
import asia.liquidinc.ekyc.applicant.external.result.auto.AutoVerificationFacePhoto
import asia.liquidinc.ekyc.applicant.external.result.auto.AutoVerificationResult
import asia.liquidinc.ekyc.applicant.external.result.chip.LiquidChipData
import asia.liquidinc.ekyc.applicant.external.result.document.DocumentImage
import asia.liquidinc.ekyc.applicant.external.result.face.FaceImage
import asia.liquidinc.ekyc.applicant.external.result.jpki.JpkiEvidence
import asia.liquidinc.ekyc.applicant.external.result.jpki.JpkiResult
import java.nio.ByteBuffer


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
    var idFacePhotoByteBuffer: ByteBuffer? = null
    if (idFacePhoto != null) {
        idFacePhotoByteBuffer = ByteBuffer.allocate(idFacePhoto.byteCount)
        idFacePhoto.copyPixelsToBuffer(idFacePhotoByteBuffer)
    }
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
        "sex" to sex?.name,
        "japaneseForeignerJudgment" to japaneseForeignerJudgment?.name,
        "residenceCardComprehensivePermission" to residenceCardComprehensivePermission,
        "residenceCardIndividualPermission" to residenceCardIndividualPermission,
        "residenceCardUpdateStatus" to isResidenceCardUpdateStatus,
        "residenceCardInfoType" to liquidResidenceCardInfoType?.name,
        "residenceCardType" to liquidResidenceCardType?.name,
        "idFacePhoto" to idFacePhotoByteBuffer?.array(),
        "nameExternalCharacters" to nameExternalCharacters?.mapNotNull {
            if (it == null) {
                null
            } else {
                val buffer = ByteBuffer.allocate(it.byteCount)
                it.copyPixelsToBuffer(buffer)
                buffer.array()
            }
        },
        "previousNameExternalCharacters" to previousNameExternalCharacters?.mapNotNull {
            if (it == null) {
                null
            } else {
                val buffer = ByteBuffer.allocate(it.byteCount)
                it.copyPixelsToBuffer(buffer)
                buffer.array()
            }
        },
        "addressExternalCharacters" to addressExternalCharacters?.mapNotNull {
            if (it == null) {
                null
            } else {
                val buffer = ByteBuffer.allocate(it.byteCount)
                it.copyPixelsToBuffer(buffer)
                buffer.array()
            }
        },
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

fun LiquidChipVerificationResult.toMap(): Map<String, Any?> {
    return mapOf(
        "result" to mapOf(
            "status" to resultStatus.name,
            "resultCode" to errorCode,
            "additionalData" to mapOf(
                "maintenanceTitle" to additionalDataTitle,
                "maintenanceMessage" to additionalDataMessage,
            ),
        ),
        "autoVerificationFacePhoto" to autoVerificationResult.autoVerificationFacePhoto?.toMap(),
        "autoVerificationFace" to autoVerificationResult.autoVerificationFace?.toMap(),
        "autoVerificationFacePassive" to autoVerificationResult.autoVerificationFacePassive?.toMap(),
        "documentImage" to documentImage?.toMap(),
        "chipData" to liquidChipData?.toMap(),
    )
}

fun AutoVerificationFacePhoto.toMap(): Map<String, Any?> {
    return mapOf(
        "resultType" to resultType.ordinal,
        "score" to score,
    )
}

fun AutoVerificationFace.toMap(): Map<String, Any?> {
    return mapOf(
        "resultType" to resultType.ordinal,
        "score" to score,
    )
}

fun AutoVerificationFacePassive.toMap(): Map<String, Any?> {
    return mapOf(
        "result" to result,
    )
}

fun DocumentImage.toMap(): Map<String, Any?> {
    var frontByteBuffer: ByteBuffer? = null
    if (front != null) {
        frontByteBuffer = ByteBuffer.allocate(front.byteCount)
        front.copyPixelsToBuffer(frontByteBuffer)
    }
    var diagonalByteBuffer: ByteBuffer? = null
    if (diagonal != null) {
        diagonalByteBuffer = ByteBuffer.allocate(diagonal.byteCount)
        diagonal.copyPixelsToBuffer(diagonalByteBuffer)
    }
    var backByteBuffer: ByteBuffer? = null
    if (back != null) {
        backByteBuffer = ByteBuffer.allocate(back.byteCount)
        back.copyPixelsToBuffer(backByteBuffer)
    }
    return mapOf(
        "front" to frontByteBuffer?.array(),
        "diagonal" to diagonalByteBuffer?.array(),
        "back" to backByteBuffer?.array(),
    )
}

fun LiquidFaceVerificationResult.toMap(): Map<String, Any?> {
    return mapOf(
        "result" to mapOf(
            "status" to resultStatus.name,
            "resultCode" to errorCode,
            "additionalData" to mapOf(
                "maintenanceTitle" to additionalDataTitle,
                "maintenanceMessage" to additionalDataMessage,
            ),
        ),
        "autoVerificationFacePhoto" to autoVerificationResult.autoVerificationFacePhoto?.toMap(),
        "autoVerificationFace" to autoVerificationResult.autoVerificationFace?.toMap(),
        "autoVerificationFacePassive" to autoVerificationResult.autoVerificationFacePassive?.toMap(),
        "faceImage" to faceImage?.toMap(),
    )
}

fun FaceImage.toMap(): Map<String, Any?> {
    val faceFrontByteBuffer = ByteBuffer.allocate(faceFront.byteCount)
    faceFront.copyPixelsToBuffer(faceFrontByteBuffer)

    return mapOf(
        "faceFront" to faceFrontByteBuffer.array(),
        "liveness" to liveness.map {
            val buffer = ByteBuffer.allocate(it.byteCount)
            it.copyPixelsToBuffer(buffer)
            buffer.array()
        },
    )
}
