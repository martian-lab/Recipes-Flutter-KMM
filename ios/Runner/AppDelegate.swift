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
    
    print("result1=")
    
    sdk = RecipesSDK.init(httpClientFactory: HttpClientFactory(),
                          driverFactory: DatabaseDriverFactory())

    recipesInteractor = sdk.interactor
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    
    let recipeChannel = FlutterMethodChannel(name: "recipes/platform",
                                                  binaryMessenger: controller.binaryMessenger)

    recipeChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
        switch call.method {
            case "getCategories":
                self.getCategories(fresult: result)
            case "getRecipesByCategory":
                self.getRecipesByCategory(call: call, result: result)
            default:
                result(FlutterMethodNotImplemented)
            }
    })

    setUpdateListener(with: recipeChannel)
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    
    func setUpdateListener(with recipeChannel: FlutterMethodChannel) {
        
        //recipesInteractor.setUpdatesListener()
        
        
        recipesInteractor.setUpdatesListener { id in
            recipeChannel.invokeMethod("updateCategory", arguments: id)
        }
        
    }
    
    func getCategories(fresult: @escaping FlutterResult) {
        //var catJson : String?
        guard let catJson = recipesInteractor?.getCategoriesAsJson(completionHandler:{ response, err in
            fresult(response)
        }) else {
            //fresult(FlutterMethodNotImplemented)
            return;
        }
        //fresult(catJson)
    }
    
    func getRecipesByCategory(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments else {
            result(FlutterError(code: "-1", message: "iOS could not extract " +
            "flutter arguments in method: (getRecipesAsCategory)", details: nil))
          return
        }
        if let catId = args as? Int32 {
            recipesInteractor.getRecipesAsJson(catId: String(catId), completionHandler:{
                response, err in
                if err == nil {
                    result(response)
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
