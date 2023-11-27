import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gdsc_app/ui/profile/components/profile_section_button.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/busy_overlay.dart';
import 'package:stacked/stacked.dart';
import '../../core/utils/constants.dart';
import '../widgets/custom_app_bar.dart';
import 'components/profile_card.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        onViewModelReady: (viewModel) => viewModel.setUser(context),
        builder: (context, viewmodel, _) {
          return Scaffold(
            backgroundColor: Constants.background,
            appBar: CustomAppBar(
                title: 'المـلـف الـشـخـصـي',
                elevation: 0,
                roundedBorder: false,
                leading: !viewmodel.fromLogin
                    ? null
                    : viewmodel.isUser
                        ? IconButton(
                            onPressed: () async {
                              bool? confirmed =
                                  await viewmodel.showWarningDialog(context);
                              if (confirmed != null && confirmed == true) {
                                await viewmodel.signOut();
                              }
                            },
                            icon: const Icon(
                              Icons.logout_rounded,
                              size: 40,
                              color: Constants.black,
                            ),
                          )
                        : null),
            body: SafeArea(
              child: Center(
                  child: BusyOverlay(
                isBusy: viewmodel.isBusy,
                child: RefreshIndicator(
                  onRefresh: viewmodel.refreshData,
                  child: ListView(
                    children: [
                      ProfileCard(
                        member: viewmodel.user,
                        edit: viewmodel.isUser
                            ? () {
                                viewmodel.navigateToEditProfile();
                              }
                            : null,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileSectionButton(
                        title: 'الفعاليات',
                        color: Constants.green,
                        icon: const Icon(
                          Icons.event_note,
                          color: Constants.green,
                          size: 30,
                        ),
                        onTap: () => viewmodel.navigateToProfileEvents(),
                      ),
                      ProfileSectionButton(
                        title: 'الساعات',
                        color: Constants.yellow,
                        icon: const Icon(
                          Icons.access_time_filled,
                          color: Constants.yellow,
                          size: 30,
                        ),
                        onTap: () => viewmodel.navigateToProfileUserHours(),
                      ),
                      ProfileSectionButton(
                        title: 'المنشورات',
                        color: Constants.red,
                        icon: Padding(
                          padding: const EdgeInsets.all(4),
                          child: SvgPicture.asset(
                            'assets/icons/profile/timeline.svg',
                            color: Constants.red,
                            height: 20,
                            width: 20,
                          ),
                        ),
                        onTap: () => viewmodel.navigateToProfileTimeline(),
                      ),
                      ProfileSectionButton(
                        title: 'منصات التواصل',
                        color: Constants.primaryLightBlue,
                        icon: const Icon(
                          Icons.chat_rounded,
                          color: Constants.primaryLightBlue,
                          size: 30,
                        ),
                        onTap: () => viewmodel.navigateToProfileSocials(),
                      ),
                      if (viewmodel.isUser)
                        ProfileSectionButton(
                          title: 'الفواتير',
                          color: Constants.green,
                          icon: const Icon(
                            Icons.receipt,
                            color: Constants.green,
                            size: 30,
                          ),
                          onTap: () => viewmodel.navigateToProfileSocials(),
                        ),
                    ],
                  ),
                ),
              )),
            ),
          );
        });
  }
}
