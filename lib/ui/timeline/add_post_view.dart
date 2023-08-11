import 'package:flutter/material.dart';
import 'package:gdsc_app/ui/widgets/submit_button.dart';
import 'package:provider/provider.dart';
import 'package:gdsc_app/ui/timeline/timeline_viewmodel.dart';
import 'package:stacked/stacked.dart';
import '../../../core/utils/constants.dart';
import '../../core/models/gdsc_user.dart';
import '../../core/models/post.dart';
import '../../core/utils/helper_functions.dart';

class AddPostView extends StatefulWidget {
  const AddPostView({super.key, this.onSubmit});
  final void Function(String postId)? onSubmit;
  @override
  State<AddPostView> createState() => _AddPostViewState();
}

class _AddPostViewState extends State<AddPostView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TimeLineViewModel>.reactive(
        viewModelBuilder: () => TimeLineViewModel(),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                child: SubmitButtons(onPressed: () {
                                  viewmodel.addPost(user);
                                  Navigator.pop(context);
                                }),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: ClipOval(
                                  child: HelperFunctions.profileImage(
                                      imageUrl: user.photo ?? '',
                                      height: 50,
                                      width: 50),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(user.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w900)),
                                  Text(user.committee.name,
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Constants.grey)),
                                ],
                              ),
                            ],
                          ),
                          CustomTextField(
                            title: '',
                            controller: viewmodel.descriptionController,
                            maxLines: 4,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 100),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.1),
                            child: SubmitButton(
                                text: 'إضـافـة',
                                onPressed: () async {
                                  String? postId =
                                      await viewmodel.addPost(user);
                                  if (widget.onSubmit != null &&
                                      postId != null) {
                                    widget.onSubmit!(postId);
                                    Navigator.pop(context);
                                  }
                                }),
                          ),
                        ],
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

Widget _TextWithChild({required String title, required Widget child}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        const SizedBox(
          height: 7,
        ),
        child,
      ],
    ),
  );
}

Widget SubmitButtons({required Function() onPressed}) {
  return TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      fixedSize: Size(90, 40),
      backgroundColor: Constants.blueButton,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    child: const Text(
      'نشر',
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget CustomTextField(
    {required String title,
    required TextEditingController controller,
    autofocus = false,
    int maxLines = 1,
    Widget? icon,
    TextInputType? type}) {
  return _TextWithChild(
    title: title,
    child: TextField(
      maxLength: 125,
      maxLines: maxLines,
      autofocus: autofocus,
      controller: controller,
      decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: icon,
          ),
          prefixIconConstraints: const BoxConstraints(maxWidth: 22 + 30),
          contentPadding: EdgeInsets.zero,
          fillColor: Colors.white,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          )),
    ),
  );
}
