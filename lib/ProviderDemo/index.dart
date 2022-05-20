import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learn_flutter/demoFour/index.dart';

class ProviderDemo extends StatefulWidget {
  const ProviderDemo({Key? key}) : super(key: key);

  @override
  State<ProviderDemo> createState() => _ProviderDemoState();
}

class _ProviderDemoState extends State<ProviderDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("demo five"),),
        body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Provider Demo"),
                SizedBox(height: 50.w,),
              ],
            ),
          ),
        )
    );
  }
}
class InheritedProvider<T> extends InheritedWidget {

  final T data;

  InheritedProvider({
    required this.data,
    required Widget child,
  }):super(child: child);

  @override
  bool updateShouldNotify(InheritedProvider<T> old) {
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {

  final Widget child;
  final T data;

  const ChangeNotifierProvider({
    Key? key,
    required this.data,
    required this.child,
  }) : super(key: key);

  static T of<T>(BuildContext context) {
    // final type = _typeOf<InheritedProvider<T>>();
    final provider = context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>();
    return provider!.data;
  }

  @override
  _ChangeNotifierProviderState<T> createState() => _ChangeNotifierProviderState();
}

class _ChangeNotifierProviderState<T extends ChangeNotifier> extends State<ChangeNotifierProvider<T>> {

  void update() {
    setState(() {

    });
  }

  @override
  void didUpdateWidget(covariant ChangeNotifierProvider<T> oldWidget) {
    // TODO: implement didUpdateWidget
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // TODO: implement initState
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class Item {
  Item(this.price, this.count);
  double price;
  int count;
}

class CartModel extends ChangeNotifier {

  final List<Item> _items = [];

  UnmodifiableListView<Item> get items => UnmodifiableListView(_items);

  double get totalPrice => _items.fold(0, (value, item) => value + item.count * item.price);

  void add(Item item) {
    _items.add(item);
    notifyListeners();
  }
}

class ProviderRoute extends StatefulWidget {
  const ProviderRoute({Key? key}) : super(key: key);

  @override
  State<ProviderRoute> createState() => _ProviderRouteState();
}

class _ProviderRouteState extends State<ProviderRoute> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ChangeNotifierProvider<CartModel>(
        data: CartModel(),
        child: Builder(builder: (context) {
          return Column(
            children: <Widget>[
              Builder(builder: (context) {
                var cart = ChangeNotifierProvider.of<CartModel>(context);
                return Text("total Price: ${cart.totalPrice}");
              }),
              Builder(builder: (context) {
                print('========');
                return ElevatedButton(
                  child: Text('添加商品'),
                  onPressed: () {
                    ChangeNotifierProvider.of<CartModel>(context).add(Item(20.0, 1));
                  },
                );
              })
            ],
          );
        },),
      ),
    );
  }
}
