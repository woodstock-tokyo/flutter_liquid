import Flutter
import Liquid
import UIKit

public class FlutterLiquidPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_liquid",
      binaryMessenger: registrar.messenger()
    )
    let instance = FlutterLiquidPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getVersion":
      getVersion(call, result: result)
    case "startVerify":
      startVerify(call, result: result)
    case "identifyIdChip":
      identifyIdChip(call, result: result)
    case "activate":
      activate(call, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  func getVersion(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(LiquidEkyc.getVersion())
  }

  func startVerify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
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
      LiquidEkyc.startVerify(
        endpoint: URL(fileURLWithPath: endpoint),
        token: token!,
        applicant: applicant!,
        apiKey: apiKey
      )

      result(nil)
      return
    }

    let _ = LiquidEkyc.startVerify(
      endpoint: URL(fileURLWithPath: endpoint),
      apiKey: apiKey,
      completion: { param in
        result(param.toDictionary())
      }
    )
  }

  func identifyIdChip(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard
      let rootViewController = UIApplication.shared.windows.filter({ (w) -> Bool in
        return w.isHidden == false
      }).first?.rootViewController
    else {
      result(FlutterError())
      return
    }

    let parameters = IdentifyIdChipParametersBuilder()
      .setVerificationMethodJpki(.complyWa)
      .setEnabledChipForgotPin(false)
      .setDocumentTypeJpki(.mynumberCardWithMyNumber)
      .build()
    LiquidEkyc.identifyIdChip(parameters, on: rootViewController, completion: { chipResult in
      result(chipResult.toDictionary())
    })
  }
  
  func activate(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    LiquidEkyc.activate(completion: { param in
      result(param.toDictionary())
    })
  }
}
