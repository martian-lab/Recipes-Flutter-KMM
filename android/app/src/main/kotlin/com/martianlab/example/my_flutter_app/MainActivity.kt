package com.martianlab.example.my_flutter_app

import android.os.Bundle
import androidx.lifecycle.ViewModelProvider
import com.martianlab.recipes.RecipesSDK
import com.martianlab.recipes.data.sources.db_new.DatabaseDriverFactory
import com.martianlab.recipes.domain.RecipesInteractor
import com.martianlab.recipes.entities.Destination
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "recipes/platform"

    val interactor: RecipesInteractor = RecipesSDK(DatabaseDriverFactory(context), RouterImpl()).interactor
    lateinit var viewModel: RecipesViewModel

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        viewModel = RecipesViewModel(interactor, MethodChannel(flutterEngine?.dartExecutor?.binaryMessenger, CHANNEL) )
    }


//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
//        channel.setMethodCallHandler(Handler (channel))
//    }
}


class Handler(val channel : MethodChannel ) : MethodChannel.MethodCallHandler{
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        println("flutter_srv: " + "MethodCall")
        channel.invokeMethod("foo", null)
    }

}

