import Flutter
import Liquid
import UIKit

public class FlutterLiquidPlugin: NSObject, FlutterPlugin {
    public static func register(
        with registrar: FlutterPluginRegistrar
    ) {
        let channel = FlutterMethodChannel(
            name: "flutter_liquid",
            binaryMessenger: registrar.messenger()
        )
        let instance = FlutterLiquidPlugin()
        registrar.addMethodCallDelegate(
            instance,
            channel: channel
        )
    }
    
    public func handle(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        switch call.method {
        case "getVersion":
            getVersion(
                call,
                result: result
            )
        case "startVerify":
            startVerify(
                call,
                result: result
            )
        case "identifyIdChip":
            identifyIdChip(
                call,
                result: result
            )
        case "verifyIdChip":
            verifyIdChip(
                call,
                result: result
            )
        case "verifyFace":
            verifyFace(
                call,
                result: result
            )
        case "activate":
            activate(
                call,
                result: result
            )
        default:
            result(
                FlutterMethodNotImplemented
            )
        }
    }
    
    func getVersion(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        result(
            LiquidEkyc.getVersion()
        )
    }
    
    
    
    func startVerify(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard let args = call.arguments as? [String: Any?] else {
            return
        }
        guard let endpoint = args["endpoint"] as? String else {
            return
        }
        guard let apiKey = args["apiKey"] as? String else {
            return
        }
        guard let applicant = args["applicant"] as? String? else {
            return
        }
        guard let token = args["token"] as? String? else {
            return
        }
        
        if applicant != nil && token != nil {
            LiquidEkyc.startVerify(endpoint: URL(
                fileURLWithPath: endpoint
            ), applicant: applicant!, token: token!)
            
            result(
                nil
            )
            return
        }
        
        let _ = LiquidEkyc.startVerify(
            endpoint: URL(
                fileURLWithPath: endpoint
            ),
            apiKey: apiKey,
            completion: {
                param in
                result(
                    param.toDictionary()
                )
            }
        )
    }
    
    func identifyIdChip(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard
            let rootViewController = UIApplication.shared.windows.filter({
                (
                    w
                ) -> Bool in
                return w.isHidden == false
            }).first?.rootViewController
        else {
            result(
                FlutterError()
            )
            return
        }
        
        let parameters = IdentifyIdChipParametersBuilder()
            .setVerificationMethodJpki(
                .complyWa
            )
            .setEnabledChipForgotPin(
                false
            )
            .setDocumentTypeJpki(
                .mynumberCardWithMyNumber
            )
            .build()
        LiquidEkyc.identifyIdChip(parameters,
                                  on: rootViewController,
                                  completion: {
            chipResult in
            result(
                chipResult.toDictionary()
            )
        })
    }
    
    func verifyIdChip(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard let args = call.arguments as? [String: Any?] else {
            result(FlutterError(
                code: "argument",
                message: "liquid_document_type and verification_method are required",
                details:"liquid_document_type and verification_method are required"
                )
            )
            return
        }
        guard let liquidDocumentTypeStr = args["liquid_document_type"] as? String else {
            result(FlutterError(
                code: "argument",
                message: "liquid_document_type is required",
                details:"liquid_document_type is required"
                )
            )
            return
        }
        guard let verificationMethodStr = args["verification_method"] as? String else {
            result(FlutterError(
                code:"argument",
                message:"verification_method is required",
                details:"verification_method is required"
                )
            )
            return
        }
        guard let liquidDocumentType = IdDocumentType.fromString(liquidDocumentTypeStr) else {
            var values = [String]()
                    for type in IdDocumentType.allCases {
                        values.append(type.toString())
                    }
            result(
                FlutterError(code: "argument",
                             message:"liquid_document_type must be chosen from \(values)",
                             details:"liquid_document_type must be chosen from \(values)")
            )
            return
        }
        guard let verificationMethod = VerificationMethod.fromString(verificationMethodStr) else {
            result(
                FlutterError(code: "argument",
                             message:"verification_method must be chosen from COMPLY_HE",
                             details:"verification_method must be chosen from COMPLY_HE")
            )
            return
        }
        
        guard
            let rootViewController = UIApplication.shared.windows.filter({
                (
                    w
                ) -> Bool in
                return w.isHidden == false
            }).first?.rootViewController
        else {
            result(
                FlutterError()
            )
            return
        }
        
        let parameters = VerifyIdChipParametersBuilder(document: liquidDocumentType, verificationMethod: verificationMethod)
            .build()
        
        LiquidEkyc.verifyIdChip(parameters,
                                on: rootViewController,
                                completion: {
            chipResult in
            print(chipResult)
            result(
                chipResult.toDictionary()
            )
        })
    }
    
    func verifyFace(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard
            let rootViewController = UIApplication.shared.windows.filter({
                (
                    w
                ) -> Bool in
                return w.isHidden == false
            }).first?.rootViewController
        else {
            result(
                FlutterError()
            )
            return
        }
        
        let parameters = VerifyFaceParametersBuilder()
            .setFaceVerificationType(
                FaceVerificationType.active
            )
            .setShowReviewScreen(
                true
            )
            .build()
        LiquidEkyc.verifyFace(
            parameters,
            on: rootViewController
        ) { verifyFaceResult in
            result(
                verifyFaceResult.toDictionary()
            )
        }
    }
    
    
    func activate(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        LiquidEkyc.activate(completion: {
            param in
            result(
                param.toDictionary()
            )
    })
  }
}
