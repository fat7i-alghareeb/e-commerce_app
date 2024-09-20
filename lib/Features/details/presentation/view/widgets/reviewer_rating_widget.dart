import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../../shared/models/review.dart';
import '../../../../../utils/assets.dart';
import '../../../../../utils/helper_extensions.dart';

class ReviewerRatingWidget extends StatelessWidget {
  const ReviewerRatingWidget({super.key, required this.review});
  final Review review;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      color: context.neutralColor(),
      elevation: 10,
      shadowColor: context.accentColor().withOpacity(.05),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          child: Image.asset(
                            AssetsImages.user,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      title: Text(
                        review.reviewerName!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      subtitle: Text(
                        review.reviewerEmail!,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  RatingBar(
                    initialRating: review.rating!.toDouble(),
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 14,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star_rounded,
                        color: context.accentColor(),
                      ),
                      half: Icon(
                        Icons.star_half_rounded,
                        color: context.accentColor(),
                      ),
                      empty: Icon(
                        Icons.star_border_rounded,
                        color: context.accentColor(),
                      ),
                    ),
                    onRatingUpdate: (rating) {},
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                review.comment!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                timeago.format(review.date!),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
