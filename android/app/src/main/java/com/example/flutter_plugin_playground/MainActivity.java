package com.example.flutter_plugin_playground;

import android.os.Bundle;
import android.util.Log;

import java.lang.reflect.Method;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.view.FlutterView;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    MethodChannel channel;

    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    // Get all instance methods of MainActivity
    // Prepare channel
    FlutterView view = getFlutterView();
    channel = new MethodChannel(view, "playground");
    channel.setMethodCallHandler(new MethodChannel.MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
        try {
          // Find a method with the same name in activity
          Method method = MainActivity.class.getDeclaredMethod(
                  methodCall.method,
                  Object.class,
                  MethodChannel.Result.class
          );

          // Call method if exists
          method.setAccessible(true);
          method.invoke(MainActivity.this, methodCall.arguments, result);
        } catch (Throwable t) {
          Log.e("Playground", "Exception during channel invoke", t);
          result.error("Exception during channel invoke", t.getMessage(), null);
        }
      }
    });
  }

  void test(Object args, MethodChannel.Result result) {
    result.success("YAY from Java!");
  }
}
