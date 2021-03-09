import 'package:async/async.dart';
import 'package:fishapp/config/themes/theme_config.dart';
import 'package:fishapp/widgets/simple_icon_shadow_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../entities/user.dart';
import '../utils/services/rest_api_service.dart';

/*
Widget that creates the stars for showing ratings.
 */
class RatingStars extends StatelessWidget {
  final double rating;

  const RatingStars({Key key, this.rating}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tmp = rating;
    List<Widget> stars = [];
    for (var n = 0; n < 5; n++) {
      if (tmp >= 1) {
        stars.add(_fullStar);
        tmp--;
      } else if (tmp >= 0.5) {
        stars.add(_halfStar);
        tmp -= 0.5;
      } else {
        stars.add(_emptyStar);
      }
    }

    return Row(
      children: stars,
    );
  }
}

/// -- Stars -- ///
final _fullStar = SimpleShadowWidget(
  iconData: Icons.star,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);
final _halfStar = SimpleShadowWidget(
  iconData: Icons.star_half,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);
final _emptyStar = SimpleShadowWidget(
  iconData: Icons.star_border,
  size: ratingStarTheme.size,
  iconColor: ratingStarTheme.color,
  blur: 1,
);

class UserRatingStars extends StatefulWidget {
  final User user;
  final RatingService ratingService = RatingService();

  UserRatingStars({Key key, this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserRatingStarsState();
}

class _UserRatingStarsState extends State<UserRatingStars> {
  num _rating = 0.0;
  CancelableOperation _future;

  @override
  void initState() {
    super.initState();
    _future = CancelableOperation.fromFuture(
            widget.ratingService.getUserRating(context, widget.user.id))
        .then((value) {
      setState(() {
        _rating = value;
      });
    });
  }

  @override
  void dispose() {
    _future.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingStars(
          rating: _rating,
        )
      ],
    );
  }
}
