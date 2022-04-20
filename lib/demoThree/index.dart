import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ThreeDemo extends StatefulWidget {
  const ThreeDemo({Key? key}) : super(key: key);

  @override
  State<ThreeDemo> createState() => _ThreeDemoState();
}

class _ThreeDemoState extends State<ThreeDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("demo tree"),),
    body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             TextInput(),
          ],
        ),
      ),
    )
    );
  }
}


class TextInput extends StatefulWidget {
  const TextInput({Key? key}) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {

  late TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: TextField(
        controller: _controller,
        autofocus: true,
        style: TextStyle(color: Colors.red),
        cursorColor: Colors.red,
        // obscureText: true,
        decoration: InputDecoration(
          // labelText: "用户名",
          hintText: "请输入用户名",
          hintStyle: TextStyle(color: Colors.blue),
          prefixIcon: Icon(Icons.person),
          filled: true,
          // fillColor: Colors.grey,
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.yellow, width: 1.w)
          )
        ),
        // scrollPadding: EdgeInsets.all(10.0),
        onChanged: (v) {
           print(v);
        }
      ),
    );
  }
}
