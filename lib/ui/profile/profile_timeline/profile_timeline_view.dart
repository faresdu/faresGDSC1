import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/post_card.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/gdsc_user.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/circle_button.dart';

class ProfileTimelineView extends StatefulWidget {
  const ProfileTimelineView({Key? key}) : super(key: key);

  @override
  State<ProfileTimelineView> createState() => _ProfileTimelineViewState();
}

class _ProfileTimelineViewState extends State<ProfileTimelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileTimelineViewModel>.reactive(
        onViewModelReady: ((viewModel) => viewModel.getPosts(context)),
        viewModelBuilder: () => ProfileTimelineViewModel(),
        builder: (context, viewmodel, _) {
          final user = Provider.of<GDSCUser>(context);

          return Scaffold(
              appBar: const CustomAppBar(
                title: 'المنشورات',
              ),
              body: SafeArea(
                child: BusyOverlay(
                  isBusy: viewmodel.isBusy,
                  child: DefaultTabController(
                      length: 2,
                      key: viewmodel.key,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        boxShadow: Constants.shadow3,
                                        color: Constants.white,
                                        borderRadius:
                                            BorderRadius.circular(25)),
                                    width: viewmodel.isUser
                                        ? MediaQuery.of(context).size.width *
                                            0.75
                                        : MediaQuery.of(context).size.width *
                                            0.93,
                                    child: TabBar(
                                      unselectedLabelStyle: Constants.smallText
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w700),
                                      labelStyle: Constants.smallText.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700),
                                      unselectedLabelColor: Colors.black,
                                      indicator: BoxDecoration(
                                          color: Constants.blueButton,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      tabs: <Widget>[
                                        Tab(
                                          text: viewmodel.isUser
                                              ? 'منشوراتي'
                                              : 'المنشورات',
                                        ),
                                        Tab(
                                          text: viewmodel.isUser
                                              ? 'المعجب بها'
                                              : 'الاعجابات',
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  if (viewmodel.isUser)
                                    CircleButton(
                                      onPressed: () {
                                        viewmodel.navigateToAddPosts(context);
                                      },
                                    ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: TabBarView(
                              children: [
                                ListView(
                                  children: viewmodel.posts
                                      .map((e) => PostCard(
                                          post: e,
                                          onLike: viewmodel.likePost,
                                          onUnLike: viewmodel.unLikePost,
                                          onDelete: viewmodel.onDelete,
                                          userId: user.id))
                                      .toList(),
                                ),
                                ListView(
                                  children: viewmodel.likedPosts
                                      .map((e) => PostCard(
                                          post: e,
                                          onLike: viewmodel.likePost,
                                          onUnLike: viewmodel.unLikePost,
                                          onDelete: viewmodel.onDelete,
                                          userId: user.id))
                                      .toList(),
                                )
                              ],
                            ))
                          ])),
                ),
              ));
        });
  }
}
