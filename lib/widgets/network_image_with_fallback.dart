import 'package:material_ui/material_ui.dart';

/// Soal 3e: Widget pembungkus Image.network dengan loading placeholder dan errorBuilder.
class NetworkImageWithFallback extends StatelessWidget {
  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
  });

  final String imageUrl;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
        if (loadingProgress == null) {
          return child;
        }
        final int? expectedBytes = loadingProgress.expectedTotalBytes;
        final double? progressValue = expectedBytes != null
            ? loadingProgress.cumulativeBytesLoaded / expectedBytes
            : null;

        return Container(
          width: width,
          height: height,
          color: colorScheme.surfaceContainerHighest,
          alignment: Alignment.center,
          child: SizedBox(
            width: 28,
            height: 28,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              value: progressValue,
              color: colorScheme.primary,
            ),
          ),
        );
      },
      errorBuilder: (
        BuildContext context,
        Object error,
        StackTrace? stackTrace,
      ) {
        return Container(
          width: width,
          height: height,
          color: colorScheme.surfaceContainerHighest,
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.broken_image_outlined,
                size: 32,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 4),
              Text(
                'Gambar tidak tersedia',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
