import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';

import 'color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewExample(),
    );
  }
}

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {

  var _url = "https://tekcart.com.au/";

  final _key = UniqueKey();
  bool _isLoadingPage;

  Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    _isLoadingPage = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Stack(
          children: <Widget>[
            new WebView(
              key: _key,
              initialUrl: _url,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (webViewCreate) {
                _controller.complete(webViewCreate);
              },
              onPageFinished: (finish) {
                setState(() {
                  _isLoadingPage = false;
                });
              },
            ),
            _isLoadingPage
                ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(),
            )
                : Container(
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffold,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 80,
                width: 80,
                color: kPrimary,
              ),
              text(),
              text(),
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      text(),
                      Expanded(
                        child: TextField(
                          // style: TextStyle(
                          //     fontSize: s_headline, color: white),
                          decoration: new InputDecoration(
                              filled: true,
                              isDense: true,
                              fillColor: Colors.white,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 8.0),
                              hintText: "data",
                              hintStyle: TextStyle(color: Colors.grey)),
                        ),
                      ),
                      //text()
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: VerticalDivider(
                  color: Colors.black,
                  width: 10,
                  thickness: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget text()
  {
    return Text("data");
  }
}
