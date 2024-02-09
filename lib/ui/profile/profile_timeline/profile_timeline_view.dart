import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/custom_tab_bar.dart';
import 'package:gdsc_app/ui/timeline/components/post_card.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/gdsc_user.dart';
import '../../widgets/circle_button.dart';

class ProfileTimelineView extends StatefulWidget {
  const ProfileTimelineView({super.key});

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
                            CustomTabBar(
                              tabs: [
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
                              widget: viewmodel.isUser
                                  ? CircleButton(
                                      onPressed: () {
                                        viewmodel.navigateToAddPosts(context);
                                      },
                                    )
                                  : null,
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
