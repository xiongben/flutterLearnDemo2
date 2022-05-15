import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import'package:flutter/rendering.dart';


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
             SizedBox(height: 20.w,),
             InkWell(
               child: Text("print tree"),
               onTap: () {
                 debugDumpApp();
               },
             ),
            SizedBox(height: 20.w,),
            InkWell(
              child: Text("print widget tree"),
              onTap: () {
                debugDumpApp();
              },
            ),
            SizedBox(height: 20.w,),
            InkWell(
              child: Text("print layer tree"),
              onTap: () {
                debugDumpLayerTree();
              },
            ),
            WrapDemo(),
            Container(
              width: 210.w,
              color: Colors.blue,
              child: ResponsiveColumn(
                children: [
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf"),
                  Text("kafajkf")
                ],
              ),
            ),
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
        autofocus: false,
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

class WrapDemo extends StatelessWidget {
  const WrapDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.yellow,
      child: Wrap(
        spacing: 15.w,
        runSpacing: 15.w,
        alignment: WrapAlignment.center,
        children: [
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("A"),),
            label: Text("jack li"),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("B"),),
            label: Text("jack li q"),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("C"),),
            label: Text("jack li tom"),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("D"),),
            label: Text("jack lick"),
          ),
          Chip(
            avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text("E"),),
            label: Text("jack lia"),
          ),
        ],
      ),
    );
  }
}

class ResponsiveColumn extends StatelessWidget {
  final List<Widget> children;
  const ResponsiveColumn({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 200.w) {
            return Column(
              children: children,
              mainAxisSize: MainAxisSize.min,
            );
          } else {
            var _children = <Widget>[];
            for (var i = 0; i < children.length; i += 2) {
              if (i+1 < children.length) {
                _children.add(Row(
                  children: [children[i], children[i+1]],
                  mainAxisSize: MainAxisSize.min,
                ));
              } else {
                _children.add(children[i]);
              }
            }
            return Column(children: _children, mainAxisSize: MainAxisSize.min,);
          }
        }
    );
  }
}
