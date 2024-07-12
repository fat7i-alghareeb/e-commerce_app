import 'package:flutter/material.dart';

import '../../../../../shared/models/review.dart';
import 'reviewer_rating_widget.dart';

class ReviewsWidget extends StatelessWidget {
  const ReviewsWidget({super.key, required this.reviews});
  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: ReviewerRatingWidget(
          review: reviews[index],
        ),
      ),
    );
  }
}
