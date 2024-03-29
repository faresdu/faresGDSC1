import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gdsc_app/core/models/member.dart';
import 'package:gdsc_app/core/utils/constants.dart';
import 'package:gdsc_app/core/utils/helper_functions.dart';

class EventParticipant extends StatelessWidget {
  const EventParticipant({required this.member, this.onPressed, Key? key})
      : super(key: key);
  final Member member;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Constants.cardBackground(context),
          boxShadow: Constants.shadow),
      child: Row(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: HelperFunctions.profileImage(
                    imageUrl: member.photo ?? '',
                    gender: member.gender ?? "",
                    height: 45,
                    width: 45),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onPressed,
                    child: Text(
                      member.name,
                      style: Constants.smallText
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  if (member.email != null && member.email!.isNotEmpty)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.email_outlined,
                          color: Constants.black(context),
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          child: Text(
                            member.email!,
                            textDirection: TextDirection.ltr,
                            style: Constants.verySmallText,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: member.email!));
                              // copied successfully
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Constants.blue,
                              size: 17,
                            ))
                      ],
                    ),
                  if (member.phoneNumber != null &&
                      member.phoneNumber!.isNotEmpty)
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: Constants.black(context),
                          size: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          member.phoneNumber!,
                          style: Constants.verySmallText,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () async {
                              await Clipboard.setData(
                                  ClipboardData(text: member.phoneNumber!));
                              // copied successfully
                            },
                            icon: const Icon(
                              Icons.copy,
                              color: Constants.blue,
                              size: 17,
                            ))
                      ],
                    )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
