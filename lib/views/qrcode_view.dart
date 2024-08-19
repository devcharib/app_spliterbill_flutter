import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrcodeView extends StatefulWidget {
  const QrcodeView({super.key});

  //construtor
  @override
  State<QrcodeView> createState() => _QrcodeViewState();
}

class _QrcodeViewState extends State<QrcodeView> {
  late String dataPage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is String) {
      dataPage = args;
    } else {
      dataPage = 'erro';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 70, 63, 58),
      appBar: AppBar(
        title: Text(
          'QrCode Page - HMIM',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple.shade700,
      ),
      resizeToAvoidBottomInset: true,
      body: Center(
        child: SizedBox(
          height: 400,
          child: Card(
            // child: ListView.builder(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0),
            //   scrollDirection: Axis.horizontal,
            //   itemCount: 10,
            //   itemBuilder: (context, index) {
            //     return Card(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                QrImageView(
                  data: dataPage,
                  version: QrVersions.auto,
                  size: 300,
                ),
                SizedBox(height: 10),
                Text('Qrcode  - $dataPage'),
              ],
            ),
          ),
          // },
          // ),
        ),
      ),
    );
  }
}
