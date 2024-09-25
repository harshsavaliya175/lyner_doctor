import Flutter
import UIKit
import flutter_downloader

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      addSecuredView()
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    var field = UITextField()
    override func applicationWillResignActive(_ application: UIApplication) {
          field.isSecureTextEntry = false
      }

      override func applicationDidBecomeActive(
          _ application: UIApplication
      ) {
          field.isSecureTextEntry = true
      }

    private func addSecuredView() {
        if (!window.subviews.contains(field)) {
            window.addSubview(field)
            field.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
            field.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            window.layer.superlayer?.addSublayer(field.layer)
            if #available(iOS 17.0, *) {
                field.layer.sublayers?.last?.addSublayer(window.layer)
            } else {
                field.layer.sublayers?.first?.addSublayer(window.layer)
            }
        }
    }

}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}