package club.woodstock.flutter_liquid

import android.app.Activity
import android.content.Intent
import asia.liquidinc.ekyc.applicant.LiquidSdk
import asia.liquidinc.ekyc.applicant.external.FaceVerificationType
import asia.liquidinc.ekyc.applicant.external.IdentifyIdChipParameters
import asia.liquidinc.ekyc.applicant.external.LiquidDocumentType
import asia.liquidinc.ekyc.applicant.external.LiquidDocumentTypeJpki
import asia.liquidinc.ekyc.applicant.external.VerificationMethod
import asia.liquidinc.ekyc.applicant.external.VerificationMethodJpki
import asia.liquidinc.ekyc.applicant.external.VerifyFaceParameters
import asia.liquidinc.ekyc.applicant.external.VerifyIdChipParameters
import asia.liquidinc.ekyc.applicant.external.result.LiquidProcessingResultStatus
import asia.liquidinc.ekyc.applicant.external.result.chip.ChipIdentificationResultStatus
import asia.liquidinc.ekyc.applicant.external.result.chip.ChipVerificationResultStatus
import asia.liquidinc.ekyc.applicant.external.result.face.FaceVerificationResultStatus

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry

/** FlutterLiquidPlugin */
class FlutterLiquidPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    PluginRegistry.ActivityResultListener {
    private var activity: Activity? = null
    private lateinit var channel: MethodChannel
    private var identifyIdChipResult: Result? = null
    private var verifyIdChipResult: Result? = null
    private var verifyFaceResult: Result? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_liquid")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getVersion" -> handleGetVersion(result)
            "startVerify" -> handleStartVerify(call, result)
            "identifyIdChip" -> handleIdentifyIdChip(result)
            "verifyIdChip" -> handleVerifyIdChip(call, result)
            "verifyFace" -> handleVerifyFace(result)
            "activate" -> handleActivate(result)
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        LiquidSdk.getInstance(activity)
            .handleChipIdentificationResult(
                requestCode,
                resultCode,
                data
            ) { res ->
                when (res.resultStatus) {
                    ChipIdentificationResultStatus.SUCCESS -> {
                        identifyIdChipResult?.success(res.toMap())
                    }

                    else -> {
                        identifyIdChipResult?.error(
                            res.resultStatus.name,
                            res.errorCode,
                            "${res.additionalDataTitle}: ${res.additionalDataMessage}"
                        )
                    }
                }
                identifyIdChipResult = null
            }

        LiquidSdk.getInstance(activity)
            .handleChipVerificationResult(
                requestCode,
                resultCode,
                data
            ) { res ->
                when (res.resultStatus) {
                    ChipVerificationResultStatus.SUCCESS -> {
                        verifyIdChipResult?.success(res.toMap())
                    }

                    else -> {
                        verifyIdChipResult?.error(
                            res.resultStatus.name,
                            res.errorCode,
                            "${res.additionalDataTitle}: ${res.additionalDataMessage}"
                        )
                    }
                }
                verifyIdChipResult = null
            }

        LiquidSdk.getInstance(activity)
            .handleFaceVerificationResult(
                requestCode,
                resultCode,
                data
            ) { res ->
                when (res.resultStatus) {
                    FaceVerificationResultStatus.SUCCESS -> {
                        verifyFaceResult?.success(res.toMap())
                    }

                    else -> {
                        verifyFaceResult?.error(
                            res.resultStatus.name,
                            res.errorCode,
                            "${res.additionalDataTitle}: ${res.additionalDataMessage}"
                        )
                    }
                }
                verifyFaceResult = null
            }

        return false
    }

    private fun handleGetVersion(result: Result) {
        result.success(LiquidSdk.getInstance(activity).version)
    }

    private var connectionId: String? = null
    private fun handleStartVerify(call: MethodCall, result: Result) {
        val endpoint = call.argument<String>("endpoint")
        val apiKey = call.argument<String>("apiKey")
        val applicantId = call.argument<String>("applicant")
        val token = call.argument<String>("token")
        if (endpoint == null || apiKey == null) {
            result.error(
                "argument",
                "endpoint and apiKey is required",
                "endpoint and apiKey is required"
            )
            return
        }

        if (applicantId != null && token != null) {
            LiquidSdk.getInstance(activity).startVerify(endpoint, applicantId, token)
            result.success(null)
            return
        }

        connectionId = LiquidSdk.getInstance(activity).startVerify(endpoint, apiKey) { res ->
            when (res.result) {
                LiquidProcessingResultStatus.SUCCESS -> result.success(res.toMap())
                else -> result.error(
                    res.result.name,
                    res.errorCode,
                    "${res.additionalDataTitle}: ${res.additionalDataMessage}"
                )
            }
        }
    }

    private fun handleIdentifyIdChip(result: Result) {
        if (identifyIdChipResult != null) {
            return
        }
        identifyIdChipResult = result
        val activity = activity ?: return
        val parameters = IdentifyIdChipParameters.Builder()
            .setVerificationMethodJpki(VerificationMethodJpki.COMPLY_WA)
            .setEnabledChipForgotPin(false)
            .setDocumentTypeJpki(LiquidDocumentTypeJpki.MY_NUMBER_CARD_WITH_MY_NUMBER)
            .build()
        LiquidSdk.getInstance(activity).identifyIdChip(parameters, activity)
    }

    private fun handleVerifyIdChip(call: MethodCall, result: Result) {
        val liquidDocumentTypeStr = call.argument<String>("liquid_document_type")
        val verificationMethodStr = call.argument<String>("verification_method")
        if (liquidDocumentTypeStr == null || verificationMethodStr == null) {
            result.error(
                "argument",
                "liquid_document_type and verification_method are required",
                "liquid_document_type and verification_method are required"
            )
            return
        }

        val liquidDocumentType: LiquidDocumentType
        try {
            liquidDocumentType = LiquidDocumentType.valueOf(liquidDocumentTypeStr)
        } catch (e: IllegalArgumentException) {
            result.error(
                "argument",
                "liquid_document_type must be chosen from ${LiquidDocumentType.values().joinToString(",")}",
                "liquid_document_type must be chosen from ${LiquidDocumentType.values().joinToString(",")}"
            )
            return
        }
        val verificationMethod: VerificationMethod
        try {
            verificationMethod = VerificationMethod.valueOf(verificationMethodStr)
        } catch (e: IllegalArgumentException) {
            result.error(
                "argument",
                "verification_method must be chosen from ${LiquidDocumentType.values().joinToString(",")}",
                "verification_method must be chosen from ${LiquidDocumentType.values().joinToString(",")}"
            )
            return
        }

        if (verifyIdChipResult != null) {
            return
        }
        verifyIdChipResult = result
        val activity = activity ?: return
        val parameters = VerifyIdChipParameters.Builder(
            liquidDocumentType,
            verificationMethod
        )
            .build()
        LiquidSdk.getInstance(activity)
            .verifyIdChip(parameters, activity)
    }

    private fun handleVerifyFace(result: Result) {
        if (verifyFaceResult != null) {
            return
        }
        verifyFaceResult = result
        val activity = activity ?: return
        val parameters = VerifyFaceParameters.Builder()
            .setFaceVerificationType(FaceVerificationType.ACTIVE)
            .setShowReviewScreen(true)
            .build()
        LiquidSdk.getInstance(activity)
            .verifyFace(parameters, activity)
    }

    private fun handleActivate(result: Result) {
        LiquidSdk.getInstance(activity).activate { res ->
            when (res.result) {
                LiquidProcessingResultStatus.SUCCESS -> result.success(res.toMap())
                else -> result.error(
                    res.result.name,
                    res.errorCode,
                    "${res.additionalDataTitle}: ${res.additionalDataMessage}"
                )
            }
        }
    }
}
