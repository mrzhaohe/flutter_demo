import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';


import 'package:demo_layout/common/CommentPageView.dart';

class CommonWebView extends StatefulWidget {
    @override
  final String url;
  final String post_id;
  CommonWebView({Key key, @required this.url, this.post_id}) : super(key: key);

  _CommonWebViewState createState() => _CommonWebViewState();
}

class _CommonWebViewState extends State<CommonWebView> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  bool _isCollect = true;

  @override
  void initState() {
    super.initState();
  }

  void _toCollect() {
    setState(() {
      if (_isCollect) {
        _isCollect = false;
      } else {
        _isCollect = true;
      }
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            
            new IconButton(
              icon: (_isCollect
                  ? Image.asset('assets/store_normal_28x26_@2x.png')
                  : Image.asset('assets/store_selected_28x26_@2x.png')),
              onPressed: () {
                _toCollect();
              },
            ),

            new IconButton(
              icon: Image.asset('assets/comment_normal_26x27_@2x.png'),
              onPressed: () {
                Navigator.of(context).push(new MaterialPageRoute(builder:(ctx){
                  return new CommentPageStateful(post_id: widget.post_id);
                }));
              },
            )

          ],
        ),
        body: WebView(
          initialUrl: widget.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webviewController) {
            _controller.complete(webviewController);
          },
        ), 
      ),
    );
  }
}
