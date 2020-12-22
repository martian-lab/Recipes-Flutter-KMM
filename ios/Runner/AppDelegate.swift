import UIKit
import Flutter
import shared

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  private var sdk: RecipesSDK!;
  private var recipesInteractor: RecipesInteractor!;
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    sdk = RecipesSDK.init(driverFactory: DatabaseDriverFactory())

    recipesInteractor = sdk.interactor
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let recipeChannel = FlutterMethodChannel(name: "recipes/platform",
                                                  binaryMessenger: controller.binaryMessenger)

    recipeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
        switch call.method {
            case "getCategories":
                self.getCategories(result: result)
            case "getRecipesByCategory":
                self.getRecipesByCategory(call: call, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
    })

    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    func getCategories(result: FlutterResult) {
        guard let oAuthUrl = recipesInteractor?.getCategoriesAsJson(success: <#T##(String) -> Void#>) else {
            result(FlutterMethodNotImplemented)
            return;
        }
        result(oAuthUrl)
    }
    
    func getRecipesByCategory(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments else {
            result(FlutterError(code: "-1", message: "iOS could not extract " +
            "flutter arguments in method: (getRecipesAsCategory)", details: nil))
          return
        }
        if let myArgs = args as? [String: Any],
            let catId = myArgs["catId"] as? Int {
            recipesInteractor.getRecipesAsJson(category: <#T##Category#>, success: <#T##(String) -> Void#>)(oauthRedirect: url, callback: {
                response, err in
                if err == nil {
                    result(true)
                } else {
                    result(FlutterError(code: "-2", message: "Error during login " +
                        "in method (login)", details: nil))
                }
            })
        } else {
            result(FlutterError(code: "-1", message: "iOS could not extract " +
            "flutter arguments in method: (login)", details: nil))
        }
    }

    
}
