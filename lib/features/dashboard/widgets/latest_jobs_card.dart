import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/common/face_pile.dart';
import '../../../models/event.dart';
import '../../../models/job.dart';
import '../../../theme/theme.dart';

class LatestJobsCard extends StatelessWidget {
  final Jobs event;
  const LatestJobsCard({
    super.key,
    required this.size,
    required this.event,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.5,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: AppColors.blueGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              const Icon(
                Icons.money,
                color: AppColors.green,
              ),
              // event.prize > 0
              //     ? Text(
              //         'Paid - ${event.prize.toString()}rs',
              //         style: AppTextStyle.textMedium.copyWith(
              //           color: AppColors.white,
              //         ),
              //       )
              //     : 
              Text(
                      'FREE',
                      style: AppTextStyle.textMedium.copyWith(
                        color: AppColors.green,
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            DateFormat(
              'd MMM yyyy hh : mm',
            ).format(
              event.startDate.toDate(),
            ),
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
           ' event.eventType',
            style: AppTextStyle.displaySemiBold.copyWith(
              color: AppColors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'event.subtitle',
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on,
                color: AppColors.red,
              ),
              Flexible(
                child: Text(
                  'event.location',
                  style: AppTextStyle.textLight.copyWith(
                    color: AppColors.lightWhite,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'event.attendees.length.toString()',
            style: AppTextStyle.textLight.copyWith(
              color: AppColors.lightWhite,
              fontSize: 12,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 8,
          ),
          const FacePile(
            profileImages: [
              'https://i.stack.imgur.com/knlmd.jpg',
              'https://i.stack.imgur.com/dBagH.png',
              'https://www.tutorialspoint.com/opencv/images/face_detection_using_camera.jpg',
            ],
          ),
        ],
      ),
    );
  }
}
