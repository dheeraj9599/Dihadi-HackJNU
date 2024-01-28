import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constant.dart';
import '../../../theme/app_text_style.dart';
import '../../../theme/theme.dart';

class Bubble extends StatelessWidget {
  final bool isMe;
  final String message;
  final String sender;

  const Bubble(
      {required this.message, required this.isMe, required this.sender});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: isMe
          ? LowerNipMessageClipper(
              MessageType.send,
              sizeOfNip: 4,
              sizeRatio: 4,
              bubbleRadius: 0,
            )
          : LowerNipMessageClipper(
              MessageType.receive,
              sizeOfNip: 4,
              sizeRatio: 4,
              bubbleRadius: 0,
            ),
      child: Container(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        padding: isMe
            ? const EdgeInsets.only(left: 60)
            : const EdgeInsets.only(right: 60),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: isMe
                ? const Color.fromARGB(
                    255,
                    217,
                    218,
                    243,
                  )
                : AppColors.lightShadowColor,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
          ),
          child: !isMe
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          backgroundImage: AssetImage(
                            IMAGE_PATH_DEFAULT_USER_PROFILE_IMAGE,
                          ),
                          radius: 14,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          'sender',
                          style: AppTextStyle.textBold.copyWith(
                            color: const Color.fromARGB(255, 131, 131, 131),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 35,
                      ),
                      child: Text(
                        message,
                        textAlign: TextAlign.start,
                        style: AppTextStyle.textRegular.copyWith(
                          color: const Color.fromARGB(
                            255,
                            92,
                            92,
                            92,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    bottom: 2,
                  ),
                  child: Text(
                    message,
                    textAlign: TextAlign.end,
                    style: AppTextStyle.textRegular.copyWith(
                      color: const Color.fromARGB(
                        255,
                        92,
                        92,
                        92,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}