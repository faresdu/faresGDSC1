import 'package:flutter/material.dart';
import 'package:gdsc_app/core/utils/form_validators.dart';
import 'package:gdsc_app/ui/timeline/add_post/add_post_viewmodel.dart';
import 'package:gdsc_app/ui/timeline/add_post/posts_viewmodel.dart';
import 'package:gdsc_app/ui/widgets/rounded_submit_button.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/utils/constants.dart';
import '../../../core/models/gdsc_user.dart';
import '../../../core/utils/helper_functions.dart';
import '../../widgets/custom_text_form_field.dart';
import '../../widgets/show_snackbar.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key, required this.postsvm});

  final PostsViewModel postsvm;

  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddPostViewModel>.reactive(
        viewModelBuilder: () => AddPostViewModel(),
        onViewModelReady: (model) => model.setPosts(widget.postsvm),
        builder: (context, viewmodel, _) {
          final user = Provider.of<GDSCUser>(context);
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 13, bottom: 8),
                  height: 4,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Form(
                        key: viewmodel.formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: ClipOval(
                                        child: HelperFunctions.profileImage(
                                            imageUrl: user.photo ?? '',
                                            gender: user.gender ?? "",
                                            height: 50,
                                            width: 50),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(user.name,
                                            style: Constants.mediumText
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w900)),
                                        Text(user.committee.name,
                                            style: Constants.extraSmallText
                                                .copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Constants.grey)),
                                      ],
                                    ),
                                  ],
                                ),
                                RoundedSubmitButton(
                                  text: 'نشر',
                                  isBusy: viewmodel.isBusy,
                                  onPressed: () async {
                                    String? postId =
                                        await viewmodel.addPost(user);
                                    if (postId != null &&
                                        viewmodel.descriptionController.text
                                            .isNotEmpty) {
                                      Navigator.pop(context);
                                      showSnackBar(context,
                                          success: true,
                                          message: 'تم نشر المنشور بنجاح');
                                    }
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTextFormField(
                              controller: viewmodel.descriptionController,
                              validator: (val) =>
                                  FormValidators.minCharsValidator(val, 10),
                              maxLines: 4,
                              maxLength: 125,
                              onSaved: (val) => viewmodel.description = val,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
