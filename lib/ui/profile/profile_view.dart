import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: ListView(
                children: [
                  Container(
                    color: Color(0xFFBFDEF5),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'الملف الشخصي',
                            style: GoogleFonts.cairo(
                              textStyle: TextStyle(fontSize: 30.0),
                            ),
                          ),
                          SizedBox(
                            height: 100.0,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Card(
                              color: Color(0xFFBFDEF5),
                              elevation: 5.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      TextButton(
                                          onPressed: () {},
                                          child: Icon(
                                            Icons.add_circle,
                                            color: Colors.black,
                                          )),
                                    ],
                                    mainAxisAlignment: MainAxisAlignment.end,
                                  ),
                                  Row(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, bottom: 15.0),
                                        child: CircleAvatar(
                                          backgroundColor: Colors.red,
                                          radius: 40.0,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 60.0,
                                      ),
                                      Text(
                                        'فارس الدحيلان',
                                        style: GoogleFonts.cairo(
                                          textStyle: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Text('قائد لجنة المطورين'),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
