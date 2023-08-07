import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_timeline/profile_timeline_viewmodel.dart';
import 'package:gdsc_app/ui/timeline/add_post_view.dart';
import 'package:gdsc_app/ui/widgets/custom_app_bar.dart';
import 'package:gdsc_app/ui/widgets/post_card.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../core/models/gdsc_user.dart';
import '../../../core/utils/constants.dart';
import '../../widgets/circle_button.dart';
import '../../widgets/custom_bottom_modal_sheet.dart';

class ProfileTimelineView extends StatefulWidget {
  const ProfileTimelineView({Key? key}) : super(key: key);

  @override
  State<ProfileTimelineView> createState() => _ProfileTimelineViewState();
}

class _ProfileTimelineViewState extends State<ProfileTimelineView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileTimelineViewModel>.reactive(
        viewModelBuilder: () => ProfileTimelineViewModel(),
        builder: (context, viewmodel, _) {
          final user = Provider.of<GDSCUser>(context);

          return Scaffold(
              appBar: const CustomAppBar(
                title: 'المنشورات',
              ),
              body: SafeArea(
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
                                      borderRadius: BorderRadius.circular(25)),
                                  width:
                                      MediaQuery.of(context).size.width * 0.75,
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
                                    tabs: const <Widget>[
                                      Tab(
                                        text: 'منشوراتي',
                                      ),
                                      Tab(
                                        text: 'المعجب بها',
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                CircleButton(
                                    onPressed: () => CustomModalBottomSheet(
                                        context,
                                        AddPostView(
                                          onSubmit: (id) =>
                                              viewmodel.addToUserPosts(id),
                                        )))
                              ],
                            ),
                          ),
                          Expanded(
                              child: TabBarView(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: viewmodel.userPosts
                                      .map((e) => PostCard(
                                          post: e,
                                          onLike: viewmodel.likePost,
                                          onUnLike: viewmodel.unLikePost,
                                          userId: user.id))
                                      .toList(),
                                ),
                              ),
                              SingleChildScrollView(
                                child: Column(
                                  children: viewmodel.likedPosts
                                      .map((e) => PostCard(
                                          post: e,
                                          onLike: viewmodel.likePost,
                                          onUnLike: viewmodel.unLikePost,
                                          userId: user.id))
                                      .toList(),
                                ),
                              )
                            ],
                          ))
                        ])),
              ));
        });
  }
}
