import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VenlyWalletSignin extends StatefulWidget {
  const VenlyWalletSignin({super.key});

  @override
  State<StatefulWidget> createState() {
    return _VenlyWalletSigninState();
  }
}

class _VenlyWalletSigninState extends State<VenlyWalletSignin> {
  var identity = "";
  final controller = WebViewController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => controller.loadRequest(
        Uri.parse("https://kdkcom1234.github.io/venly_wallet_proxy")));
  }

  @override
  Widget build(BuildContext context) {
    controller
      ..setUserAgent("random")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..addJavaScriptChannel("flutterHandler", onMessageReceived: (message) {
        setState(() {
          final msgMap = jsonDecode(message.message);
          identity = "${msgMap["subject"]}\n${msgMap["address"]}";
        });
      });

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: WebViewWidget(controller: controller)),
          Row(
            children: [Text(identity)],
          ),
        ],
      ),
    );
  }
}
