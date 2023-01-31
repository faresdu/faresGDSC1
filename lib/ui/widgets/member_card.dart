import 'package:flutter/material.dart';
import '../../core/models/member.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberCard extends StatelessWidget {
  final void Function() onPressed;
  final Member member;
  final String? role;

  const MemberCard(
      {Key? key, required this.onPressed, required this.member, this.role})
      : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration:
          BoxDecoration(
            borderRadius: 
            BorderRadius.all(
              Radius.circular(12),//was 20
              ),
            color:(role=="قائد")? Color(0xFFF9EEED):(role=="نائب القائد")? Color(0xFFFDF9EE): Color(0xFFF6FAFC),
            border: Border.all(
                          color:(role=="قائد")? Color(0xFFA0461A):(role=="نائب القائد")? Color(0xFFE7B94A): Color(0xFF0682BC),
                          width: 0.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,//.withOpacity(0.5),
                            spreadRadius: 0.25,
                            blurRadius: 7,
                          ),
                        ],
          ),
          //child: Padding(//replacment of text button padding
      //padding: const EdgeInsets.symmetric(vertical: 12),//replacment of text button padding
      child: TextButton(//was TextButton
      
          style: TextButton.styleFrom(
            
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(12), // <-- Radius
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              ),
          onPressed: onPressed,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ///Profile Image
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Container(//container to add the colored border with shadow
                      decoration: BoxDecoration(
                        border: Border.all(
                          color:(role=="قائد")? Color(0xFFA0461A):(role=="نائب القائد")? Color(0xFFE7B94A): Color(0xFF0682BC),
                          width: 0.5,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 0.25,
                            blurRadius: 7,
                          ),
                        ],
                      ),

                      child: ClipOval(
                        child: profileImage()
                      ),

                    ),

                  ),

                  /// Member Info
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(member.name,
                          style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                      Text(role ?? 'عضو',
                          style: TextStyle(fontSize: 13, color: Colors.black)),
                      Text(member.major,
                          style: TextStyle(fontSize: 13, color: Colors.black))
                    ],
                  )
                ],
              ),


              if(member.socials!=null)
              Padding( padding: const EdgeInsets.symmetric(horizontal: 36),
              child: Divider(
              color: Color.fromARGB(191, 217, 217, 217)
              ),


              ),

              

              /// Social Media icons
              if (member.socials != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: 
                    member.socials!
                        .map((e) => socialImage(e.image))
                        .toList()
                )
            ],
          ),
      ),
    //),//replacment of text button padding
    );
  }

  Widget socialImage(image) {
    return GestureDetector(
    child:Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.network(
        image,
        height: 30,
      ),
    ),
    onTap: () async {
      //launchUrl(Uri.parse('https://www.google.com'));
      if (!await launchUrl(Uri.parse('https://www.google.com'))) {
    throw Exception('Could not launch link');
  }
    },
    );
  }

  Widget profileImage() {
    if (member.photo != null && member.photo!.isNotEmpty) {
      return Image.network(
        member.photo!,
        height: 65,//was 50
        width: 65,//was 50
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      "assets/images/man.png",
      height: 65,
      width: 65,
      fit: BoxFit.cover,
    );
  }
}
