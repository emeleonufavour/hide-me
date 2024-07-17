// import Flutter
// import UIKit

// @UIApplicationMain
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let heicToPngChannel = FlutterMethodChannel(name: "heic_to_png",
                                                binaryMessenger: controller.binaryMessenger)

    heicToPngChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "convert" {
        guard let args = call.arguments as? [String: Any],
              let filePath = args["filePath"] as? String else {
          result(FlutterError(code: "INVALID_ARGUMENT", message: "File path required", details: nil))
          return
        }
        self.convertHeicToPng(filePath: filePath, result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func convertHeicToPng(filePath: String, result: @escaping FlutterResult) {
    let url = URL(fileURLWithPath: filePath)
    guard let ciImage = CIImage(contentsOf: url) else {
      result(FlutterError(code: "UNAVAILABLE", message: "Unable to load HEIC image", details: nil))
      return
    }
    let context = CIContext()
    guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
      result(FlutterError(code: "UNAVAILABLE", message: "Unable to create CGImage", details: nil))
      return
    }
    let uiImage = UIImage(cgImage: cgImage)
    guard let data = uiImage.pngData() else {
      result(FlutterError(code: "UNAVAILABLE", message: "Unable to convert to PNG", details: nil))
      return
    }
    let pngPath = NSTemporaryDirectory().appending(UUID().uuidString).appending(".png")
    do {
      try data.write(to: URL(fileURLWithPath: pngPath))
      result(pngPath)
    } catch {
      result(FlutterError(code: "UNAVAILABLE", message: "Unable to save PNG", details: nil))
    }
  }
}
