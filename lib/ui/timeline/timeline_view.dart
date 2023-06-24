import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/post_card.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

import '../widgets/bottom_sheet_post.dart';
import 'add_post_view.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({Key? key}) : super(key: key);

  @override
  _TimeLineViewState createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeLineViewModel>.reactive(
      viewModelBuilder: () => TimeLineViewModel(),
      onModelReady: (model) => model.getPosts(),
      builder: (context, viewmodel, _) {
        final user = Provider.of<GDSCUser>(context);

        return Scaffold(
          backgroundColor: Constants.grayBackGround,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              bottomSheetPost(context, AddPostView());
            },
            backgroundColor: Constants.blueButton,
            heroTag: 'addPostTag',
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          ),
          appBar: CustomAppBar(
              title: "المنشورات",
              leading: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "./assets/images/BarLogo.png",
                ),
              ),
              leadingWidth: 100),
          body: SafeArea(
            child: Center(
              child: viewmodel.isBusy
                  ? const CircularProgressIndicator()
                  : RefreshIndicator(
                      onRefresh: viewmodel.getPosts,
                      child: SingleChildScrollView(
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
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
