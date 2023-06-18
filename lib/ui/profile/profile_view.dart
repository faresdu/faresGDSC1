import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
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
        onViewModelReady: ((viewModel) => viewModel.listenToUser()),
        builder: (context, viewmodel, _) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: viewmodel.hasError
                    ? Text(viewmodel.modelError!)
                    : viewmodel.isBusy
                        ? const CircularProgressIndicator()
                        : RefreshIndicator(
                            onRefresh: viewmodel.refreshData,
                            child: ListView(
                              children: [
                                CustomAppBar(
                                  title: 'المـلـف الـشـخـصـي',
                                  leading: IconButton(
                                    onPressed: () async {
                                      await viewmodel.signOut();
                                    },
                                    icon: const Icon(
                                      Icons.logout_rounded,
                                      size: 40,
                                      color: Constants.black,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                                  child: ProfileCard(
                                    member: viewmodel.user,
                                    edit: () {
                                      viewmodel.navigateToEditProfile();
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Flex(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    direction: Axis.horizontal,
                                    children: viewmodel.getButtons(),
                                  ),
                                ),
                                const Divider(
                                  endIndent: 30,
                                  indent: 30,
                                  color: Constants.grey,
                                  thickness: 2,
                                  height: 30,
                                ),
                                viewmodel.getBottomWidget(context),
                              ],
                            ),
                          ),
              ),
            ),
          );
        });
  }
}
