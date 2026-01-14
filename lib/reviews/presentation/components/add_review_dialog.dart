import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/core/domain/entities/media_details.dart';
import 'package:movies_app/core/resources/app_colors.dart';
import 'package:movies_app/profile/presentation/controllers/profile_cubit.dart';
import 'package:movies_app/reviews/presentation/controllers/reviews_bloc/reviews_bloc.dart';
import 'package:movies_app/core/services/service_locator.dart';
import 'package:movies_app/core/utils/enums.dart';

class AddReviewDialog extends StatefulWidget {
  final MediaDetails mediaDetails;

  const AddReviewDialog({super.key, required this.mediaDetails});

  @override
  State<AddReviewDialog> createState() => _AddReviewDialogState();
}

class _AddReviewDialogState extends State<AddReviewDialog> {
  double _rating = 7.0;
  final TextEditingController _reviewController = TextEditingController();

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.read<ProfileCubit>().state;

    if (profile == null) {
      return AlertDialog(
        title: const Text('Giriş Gerekli'),
        content: const Text('Değerlendirme yapmak için lütfen giriş yapın.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      );
    }

    return BlocProvider(
      create: (context) => sl<ReviewsBloc>(),
      child: BlocConsumer<ReviewsBloc, ReviewsState>(
        listener: (context, state) {
          if (state.actionStatus == ReviewActionStatus.added) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Değerlendirmeniz kaydedildi!'),
                duration: Duration(seconds: 2),
              ),
            );
          } else if (state.status == ReviewsRequestStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message.contains('already')
                    ? 'Bu film için zaten bir değerlendirme yapmışsınız.'
                    : 'Hata: ${state.message}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          return AlertDialog(
            title: Text(
              widget.mediaDetails.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Puanınız',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: AppColors.ratingIconColor,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        _rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        ' / 10',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                  Slider(
                    value: _rating,
                    min: 1,
                    max: 10,
                    divisions: 18,
                    activeColor: AppColors.primary,
                    onChanged: (value) {
                      setState(() {
                        _rating = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Yorumunuz (Opsiyonel)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reviewController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Film hakkında düşünceleriniz...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: state.status == ReviewsRequestStatus.loading
                    ? null
                    : () {
                        context.read<ReviewsBloc>().add(
                              AddReviewEvent(
                                userId: profile.userId,
                                movieId: widget.mediaDetails.tmdbID,
                                rating: _rating,
                                reviewText: _reviewController.text.isNotEmpty
                                    ? _reviewController.text
                                    : null,
                                title: widget.mediaDetails.title,
                                posterPath: widget.mediaDetails.posterUrl,
                                voteAverage: widget.mediaDetails.voteAverage,
                                releaseDate: widget.mediaDetails.releaseDate,
                              ),
                            );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: state.status == ReviewsRequestStatus.loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Kaydet'),
              ),
            ],
          );
        },
      ),
    );
  }
}

void showAddReviewDialog(BuildContext context, MediaDetails mediaDetails) {
  showDialog(
    context: context,
    builder: (context) => AddReviewDialog(mediaDetails: mediaDetails),
  );
}
