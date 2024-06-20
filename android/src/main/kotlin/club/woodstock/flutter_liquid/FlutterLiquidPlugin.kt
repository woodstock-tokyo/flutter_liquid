package club.woodstock.flutter_liquid

import android.app.Activity
import android.content.Intent
import asia.liquidinc.ekyc.applicant.LiquidSdk
import asia.liquidinc.ekyc.applicant.external.IdentifyIdChipParameters
import asia.liquidinc.ekyc.applicant.external.LiquidDocumentTypeJpki
import asia.liquidinc.ekyc.applicant.external.VerificationMethodJpki
import asia.liquidinc.ekyc.applicant.external.result.LiquidProcessingResultStatus
import asia.liquidinc.ekyc.applicant.external.result.chip.ChipIdentificationResultStatus

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

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_liquid")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getVersion" -> handleGetVersion(result)
            "startVerify" -> handleStartVerify(call, result)
            "identifyIdChip" -> handleIdentifyIdChip(result)
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
                        // TODO
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
            LiquidSdk.getInstance(activity).startVerify(endpoint, apiKey, applicantId, token)
            result.success(null)
            return
        }

        connectionId = LiquidSdk.getInstance(activity).startVerify(endpoint, apiKey) { res ->
            when (res.result) {
                LiquidProcessingResultStatus.SUCCESS -> result.success(connectionId)
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
