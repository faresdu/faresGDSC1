import 'package:flutter/material.dart';
import 'package:gdsc_app/core/models/gdsc_user.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/post_card.dart';
import 'package:stacked/stacked.dart';
import 'package:provider/provider.dart';

class TimeLineView extends StatefulWidget {
  const TimeLineView({Key? key}) : super(key: key);


  @override
  State<TimeLineView> createState() => _TimeLineViewState();
}

class _TimeLineViewState extends State<TimeLineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeLineViewModel>.reactive(
      viewModelBuilder: () => TimeLineViewModel(),
      onViewModelReady: (model) => model.getPosts(),
      builder: (context, viewmodel, _) {
        final user = Provider.of<GDSCUser>(context);

        return Scaffold(
          backgroundColor: Constants.background,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              viewmodel.navigateToAddPosts(context);
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
              leading: Image.asset(
                "./assets/images/GDSC/GDSC.png",
              ),
              leadingWidth: 100),
          body: SafeArea(
            child: Center(
              child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: RefreshIndicator(
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
                            onUserTap: () =>
                                viewmodel.navigateToMemberProfile(
                                    e.posterId),
                          ))
                              .toList(),
                        ),
                      ],
                    ),
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
