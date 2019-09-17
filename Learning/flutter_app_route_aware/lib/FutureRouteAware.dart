import 'package:flutter/material.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

//ValueNotifier<List> arrayFeatureScreen = ValueNotifier([]);
final List listArrayClass = [];

class FeatureFlagWidget extends StatefulWidget {
  FeatureFlagWidget({this.child});

  final Widget child;

  @override
  _FeatureFlagWidgetState createState() => _FeatureFlagWidgetState();
}

class _FeatureFlagWidgetState extends State<FeatureFlagWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didPush() {
    print("didPush ${listArrayClass.last}");
    // To avoid updating while widget is building
//    Future.microtask(() {
//
//    });
  }

  @override
  void didPopNext() {
    print("didPopNext ${listArrayClass.last}");
    listArrayClass.removeLast();
  }

  @override
  void didPop() {
    print("didPop ${listArrayClass.last}");

  }

  @override
  void didPushNext() {
    print("didPushNext ${listArrayClass.last}");

  }

  @override
  Widget build(BuildContext context) => widget.child;
}

void pushMaterialPageRoute(BuildContext context, Widget child) =>
    Navigator.of(context).push(
        MaterialPageRoute<void>(builder: (BuildContext context) => child));