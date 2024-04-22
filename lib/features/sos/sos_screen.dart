import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SOSScreen extends StatefulWidget {
  const SOSScreen({super.key});

  @override
  State<SOSScreen> createState() => _SOSScreenState();
}

class _SOSScreenState extends State<SOSScreen> {
  Future<void>? _launched;

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        leadingWidth: 80,
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back,
            size: 50,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shrinkWrap: true,
        children: [
          const Center(
            child: Text(
              "SOS",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 70,
              ),
            ),
          ),

          /// 101
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/free.png",
                  height: width < 391 ? 100 : 120,
                ),
                Text(
                  "101",
                  style: TextStyle(
                      fontSize: width < 391 ? 80 : 90,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    _launched = _makePhoneCall("101");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    size: width < 391 ? 85 : 100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          /// 102
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/poliscy.webp",
                  height: width < 391 ? 100 : 120,
                ),
                Text(
                  "102",
                  style: TextStyle(
                      fontSize: width < 391 ? 80 : 90,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    _launched = _makePhoneCall("102");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    size: width < 391 ? 85 : 100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 15,
          ),

          /// 103
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  CupertinoIcons.add_circled,
                  size: width < 391 ? 100 : 120,
                  color: Colors.red,
                ),
                Text(
                  "103",
                  style: TextStyle(
                      fontSize: width < 391 ? 80 : 90,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    _launched = _makePhoneCall("103");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    size: width < 391 ? 85 : 100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          /// 050
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/fvv.jpg",
                  height: width < 391 ? 100 : 120,
                ),
                Text(
                  "050",
                  style: TextStyle(
                      fontSize: width < 391 ? 80 : 90,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    _launched = _makePhoneCall("050");
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Icon(
                    Icons.phone_in_talk_outlined,
                    size: width < 391 ? 85 : 100,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ],
      ),
    );
  }
}
