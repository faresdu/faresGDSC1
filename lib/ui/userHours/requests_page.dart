import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/constants.dart';

class Requestspage extends StatefulWidget {
  const Requestspage({Key? key}) : super(key: key);

  @override
  State<Requestspage> createState() => _RequestspageState();
}

class _RequestspageState extends State<Requestspage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      backgroundColor: Color(0xffF1F1F1),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(
              height: 35,
            ),
            Row(
              children: [
                Spacer(),
                Text(
                  'الطلبات',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 19,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.175,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Text(
                            'الصفحة الرئيسية',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              color: Constants.blueButton,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: 12,
                            color: Constants.blueButton,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(25)),
              child: TabBar(
                controller: _tabController,
                unselectedLabelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                    color: Constants.blueButton,
                    borderRadius: BorderRadius.circular(25)),
                tabs: <Widget>[
                  Tab(
                    text: 'القادمة',
                  ),
                  Tab(
                    text: 'السابقة',
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Container(
                child: TabBarView(controller: _tabController, children: [
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return _reuseableWidget();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    itemCount: 100,
                    itemBuilder: (context, index) {
                      return _reuseableWidget();
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: 12,
                      );
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _reuseableWidget() {
    return Stack(
      children: [
        Container(
          height: 183,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Padding(
            padding: EdgeInsets.only(right: 20),
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.035,
                  right: MediaQuery.of(context).size.width * 0.15,
                  top: 10,
                  bottom: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'تعبئة شيت الساعات',
                          style: TextStyle(
                            color: Color(0xff343A40),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        Text(
                          "السبت ، 2023-20-6",
                          style: TextStyle(
                            color: Color(0xffAEAEAE),
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "رزان الضفيان",
                          style: TextStyle(
                            color: Color(0xffAEAEAE),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_filled,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'طلب ساعتان',
                          style: TextStyle(
                            color: Color(0xffAEAEAE),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        Container(
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xffA4D0A2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white30,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'قبول',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            height: 25,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                border: Border.all(
                                  color: Color(0xffEA4335),
                                )),
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 3),
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xffEA4335),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 13,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  'رفض',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
            child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/images/avatar.png',
                ),
                fit: BoxFit.fill),
            shape: BoxShape.circle,
          ),
        ))
      ],
    );
  }
}
