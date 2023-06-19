import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/post_card.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({Key? key}) : super(key: key);

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<GDSCUser>(context);
    return ViewModelBuilder<TimeLineViewModel>.reactive(
      viewModelBuilder: () => TimeLineViewModel(),
      onModelReady: (model) => model.getPosts(),
      builder: (context, viewmodel, _) {
        return Scaffold(
          backgroundColor: Constants.grayBackGround,
          body: SingleChildScrollView(
            child: SafeArea(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: Image.asset("./assets/images/BarLogo.png"),
                          ),
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Text(
                                  "المنشورات",
                                  style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          const Column(
                            children: [
                              SizedBox(
                                width: 110,
                              )
                            ],
                          ),
                        ]),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: viewmodel.posts
                                  .map((e) => PostCard(
                                        post: e,
                                        userId: user.id,
                                        onLike: viewmodel.likePost,
                                        onUnLike: viewmodel.unLikePost,
                                      ))
                                  .toList(),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
