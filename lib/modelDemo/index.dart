import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'User.dart';


class ModelTestDemo extends StatefulWidget {
  const ModelTestDemo({Key? key}) : super(key: key);

  @override
  State<ModelTestDemo> createState() => _ModelTestDemoState();
}

class _ModelTestDemoState extends State<ModelTestDemo> {

  static const test_json = {
    "name": "John Smith",
    "email": "john@example.com",
    "mother":{
      "name": "Alice",
      "email":"alice@example.com"
    },
    "friends":[
      {
        "name": "Jack",
        "email":"Jack@example.com",
        "age": 56
      },
      {
        "name": "Nancy",
        "email":"Nancy@example.com",
        "age": 56
      }
    ]
  };



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    User user_one = User.fromJson(test_json);
    print('=================');
    print(user_one.name);
    print(user_one.mother.name);
    print('=================');
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("model Demo"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("model Demo"),
              ],
            ),
          ),
        )
    );
  }
}

