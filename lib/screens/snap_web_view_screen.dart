import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pet_care_icp/components/size_helper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SnapWebViewScreen extends StatefulWidget {
  static const routeName = '/snap-webview';

  const SnapWebViewScreen({Key? key}) : super(key: key);

  @override
  State<SnapWebViewScreen> createState() => _WebViewAppState();
}

class _WebViewAppState extends State<SnapWebViewScreen> {
  var loadingPercentage = 0;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final url = routeArgs['url'];
    // final url = 'http://127.0.0.1:8000/webview/dcff21eb-5999-43b1-8749-ad0aaed9c55d';
    return Scaffold(
      body: SafeArea(
        top: false,
        // minimum: EdgeInsets.only(top: 13),
        child: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: WebView(
                  initialUrl: url,
                  onPageStarted: (url) {
                    setState(() {
                      loadingPercentage = 0;
                    });
                  },
                  onProgress: (progress) {
                    setState(() {
                      loadingPercentage = progress;
                    });
                  },
                  onPageFinished: (url) {
                    setState(() {
                      loadingPercentage = 100;
                    });
                  },
                  navigationDelegate: (navigation) {
                    final host = Uri.parse(navigation.url).toString();
                    if (host.contains('gojek://') ||
                        host.contains('shopeeid://') ||
                        host.contains('//wsa.wallet.airpay.co.id/') ||
                        // This is handle for sandbox Simulator
                        host.contains('/gopay/partner/') ||
                        host.contains('/shopeepay/') ||
                        host.contains('/pdf')) {
                      _launchInExternalBrowser(Uri.parse(navigation.url));
                      return NavigationDecision.prevent;
                    } else {
                      return NavigationDecision.navigate;
                    }
                  },
                  javascriptMode: JavascriptMode.unrestricted,
                  javascriptChannels: <JavascriptChannel>{
                    JavascriptChannel(
                      name: 'messageHandler',
                      onMessageReceived: (JavascriptMessage message) {
                        print(
                            "message from the web view=\"${message.message}\"");
                        if (message.message == 'success') {
                          Navigator.of(context)
                              .pushNamedAndRemoveUntil('/', (route) => false);
                        }
                      },
                    )
                  }),
            ),
            Container(
              margin:
                  EdgeInsets.fromLTRB(displayWidth(context) * 0.88, 30, 0, 0),
              height: 30,
              width: 60,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0.0,
                      backgroundColor: Color.fromARGB(0, 0, 0, 0),
                      shadowColor: Colors.transparent),
                  child: Icon(Icons.close)),
            ),
            if (loadingPercentage < 100)
              LinearProgressIndicator(
                value: loadingPercentage / 100.0,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchInExternalBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
}
