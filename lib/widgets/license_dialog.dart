import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:smartify/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class LicenseDialog extends StatelessWidget {
  final routeName;
  const LicenseDialog({Key? key, @required this.routeName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.all(Radius.circular(15)),
        child: Container(
          height: height(context) * 0.6,
          width: width(context) * 0.85,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    // color: Colors.blue,
                    height: height(context) * 0.07,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Center(
                        child: Text(
                          'User Agreement and Privacy Policy',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: height(context) * 0.438,
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            style: TextStyle(color: Colors.black87, fontSize: 16),
                            text:
                                'We understand the importance of privacy. In order to more fully present our'
                                'collection and use of your personal information, we have revised our privacy policy'
                                'and user agreement in detail in accordance with the latest laws and regulations. '
                                'When you click [Agree], you have fully read, understood and accepted all of the updated'
                                'Privacy Policy and User Agreement. Please take some time to become familiar with our privacy '
                                'policy, and if you have any questions, please feel free to contact us.\n\n',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            text: 'Privacy Policy',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final url =
                                    'https://github.com/flutter/gallery/';
                                if (await canLaunch(url)) {
                                  await launch(
                                    url,
                                    forceSafariVC: false,
                                  );
                                }
                              },
                          ),
                          TextSpan(
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                              text: ' and ',
                          ),
                          TextSpan(
                            style: TextStyle(color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                            text: 'User Agreement',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final url =
                                    'https://github.com/flutter/gallery/';
                                if (await canLaunch(url)) {
                                  await launch(
                                    url,
                                    forceSafariVC: false,
                                  );
                                }
                              },
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
              Divider(height: 0, thickness: 2,),
              IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        child: Text('Disagree', style: TextStyle(color: Colors.black87),),
                      ),
                    ),
                    VerticalDivider(width: 1, thickness: 2,),
                    Expanded(
                      child: MaterialButton(
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.pushNamed(context, routeName);
                        },
                        child: Text('Agree', style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
