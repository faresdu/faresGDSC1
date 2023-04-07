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
                        SizedBox(
                            height: 30.0), // Add some space before the title
                        Text(
                          'الملف الشخصي',
                          style: GoogleFonts.cairo(
                            textStyle: TextStyle(fontSize: 30.0),
                          ),
                        ),
                        SizedBox(height: 60.0),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Card(
                            color: Color(0xFFBFDEF5),
                            elevation: 15.0,
                            shadowColor: Colors.black,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(
                                        right: 20.0,
                                        bottom: 15.0,
                                      ),
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
                                      padding:
                                          const EdgeInsets.only(bottom: 10.0),
                                      child: Text('عضو لجنة المطورين'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Text(
                                        '4',
                                        style: TextStyle(
                                            fontSize: 30.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 20.0),
                                    Expanded(
                                      child: Text(
                                        'المشاركات',
                                        style:
                                            GoogleFonts.cairo(fontSize: 15.0),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Text(
                                        'المنشورات',
                                        style:
                                            GoogleFonts.cairo(fontSize: 15.0),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                    Expanded(
                                      child: Text(
                                        'الساعات',
                                        style:
                                            GoogleFonts.cairo(fontSize: 15.0),
                                      ),
                                    ),
                                    SizedBox(width: 50),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
