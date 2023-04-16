import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/profile/profile_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
        viewModelBuilder: () => ProfileViewModel(),
        builder: (context, viewmodel, _) {
          return Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: viewmodel.hasError
                ? Text(viewmodel.modelError!)
                : Center(
                    child: viewmodel.isBusy
                        ? const CircularProgressIndicator()
                        : Column(
                            children: [
                              Text(viewmodel.data!.name),
                              Text(viewmodel.data!.committee.name),
                              Text(viewmodel.data!.socials.first.name),
                              Text(viewmodel.data!.socials.first.username),
                              CachedNetworkImage(
                                  imageUrl:
                                      viewmodel.data!.socials.first.image),
                              Text(viewmodel.data!.volunteerHours.first.hours
                                  .toString()),
                            ],
                          ),
                  ),
          );
        });
  }
}
