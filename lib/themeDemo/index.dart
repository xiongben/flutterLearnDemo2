
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeDemo extends StatefulWidget {
  const ThemeDemo({Key? key}) : super(key: key);

  @override
  State<ThemeDemo> createState() => _ThemeDemoState();
}

class _ThemeDemoState extends State<ThemeDemo> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData () async {
    var dio = Dio();
    dio.options
    ..headers = {
      'common-header': 'yyyyyyyy'
    };

    //拦截器
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['token'] = 'xb88888888888888';
        print(options.headers);
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      }
    ));



    var params = {
      'appid': 43632387,
      'appsecret': 'BsIHw9B7',
      'version': 'v9',
      'city': '长沙'
    };
    final response = await dio.get('https://www.tianqiapi.com/api',queryParameters: params);
    print(response.data);
  }

  var _themeColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
        primarySwatch: _themeColor,
        iconTheme: IconThemeData(color: _themeColor)
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("主题测试"),),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  getData();
                },
                child: Text("get data")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色跟随主题")
                ],
              ),
            Theme(
              data: ThemeData(
                iconTheme: themeData.iconTheme.copyWith(
                  color: Colors.black
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("颜色固定黑色")
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            setState(()=>{
              _themeColor = _themeColor == Colors.teal ? Colors.blue : Colors.teal
            })
          },
          child: Icon(Icons.palette),
        )
      ),
    );
  }
}
