// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/events/components/events_card.dart';
import 'package:gdsc_app/ui/events/events_viewmodel.dart';
import 'package:stacked/stacked.dart';

class EventsView extends StatefulWidget {
  const EventsView({Key? key}) : super(key: key);

  @override
  State<EventsView> createState() => _EventsViewState();
}

class _EventsViewState extends State<EventsView> {

  TextEditingController Controller1  = TextEditingController();
  TextEditingController Controller2  = TextEditingController();
  TextEditingController Controller3  = TextEditingController();
  TextEditingController Controller4  = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsViewModel>.reactive(
        viewModelBuilder: () => EventsViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: Image.asset("./assets/images/BarLogo.png"),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Text(
                                "الفعاليات",
                                style: TextStyle(
                                    fontSize: 32, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: const [
                            SizedBox(
                              width: 110,
                            )
                          ],
                        ),
                      ]),
                  Column(
                    children: viewmodel.events
                        .map(
                          (e) => EventCard(
                            event: e,
                            signUpButton: viewmodel.getSignUpCardButton(e),
                            onPressed: () {
                              viewmodel.navigateToEvent(context, e);
                            },
                          ),
                        )
                        .toList(),
                  )
                ]),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.startFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Color(0xffF1F1F1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(30),
                        topLeft: Radius.circular(30)),
                  ),
                  builder: (context) {
                    return FractionallySizedBox(
                      heightFactor: 0.9,
                        child: _buildNewEvent(context,Controller1,Controller2,Controller3,Controller4));
                  },
                );
              },
              backgroundColor: Constants.blueButton,
              child: Icon(
                Icons.add,
                size: 30,
              ),
            ),
          );
        });
  }
}

Widget _buildNewEvent(BuildContext context,TextEditingController? controller1,TextEditingController? controller2,TextEditingController? controller3,TextEditingController? controller4) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 15,),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 13,),
        Container(
          height: 4,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Expanded(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'إضافة فعالية',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/images/addImage.png',
                        height: 24,
                        width: 24,
                      )),
                  TextFieldWithText(context,controller1,'العنوان',1),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(child: DateAndTime(context,'التاريخ','assets/images/Calender.png')),
                      SizedBox(width: 15,),
                      Expanded(child: DateAndTime(context,'الوقت','assets/images/Timer.png')),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(child: TextFieldWithText(context, controller2,'النوع',1)),
                      SizedBox(width: 15,),
                      Expanded(child: DateAndTime(context,'الوقت','assets/images/persons.png')),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWithText(context,controller3,'الموقع',1),
                  SizedBox(
                    height: 10,
                  ),
                  TextFieldWithText(context,controller4,'الوصف',4),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
                    child: Container(
                      height: 35,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Constants.blueButton,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'إضـافـة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 13,),
      ],
    ),
  );
}

Widget TextFieldWithText(BuildContext context,TextEditingController? controller,String text,int? maxLines) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 5,),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:  EdgeInsets.symmetric(vertical: 0),
          child: TextField(
            maxLines: maxLines,
            controller: controller,
            decoration: InputDecoration(
              hintText: '',
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 15),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget DateAndTime(BuildContext context,String text,String ImagePath){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        text,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 5,),
      Container(
        height: 46,width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.asset(ImagePath,height: 18,width: 18,),
            ],
          ),
        ),
      ),
    ],
  );
}
