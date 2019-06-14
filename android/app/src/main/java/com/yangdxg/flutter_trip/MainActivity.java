package com.yangdxg.flutter_trip;

import android.os.Bundle;

import com.yangdxg.asr_plugin.asr.AsrPlugin;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

import org.devio.flutter.splashscreen.SplashScreen;


public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        //设置Android启动屏
        //iOS中在Assets.xcassets中放入资源文件
        //在LaunchScreen.storyboard中设置背景图片（右侧更改Image名字会有提示）（view下第一个图片就是。
        // 按住cotro拖动图片到父布局view可以选择宽度等于父布局，右侧可以是这图片填充样式）
        SplashScreen.show(this, true);
        super.onCreate(savedInstanceState);
        GeneratedPluginRegistrant.registerWith(this);
        registerSelfPlugin();
    }

    private void registerSelfPlugin() {
        AsrPlugin.registerWith(registrarFor("com.yangdxg.asr_plugin.asr.AsrPlugin"));
    }

}
