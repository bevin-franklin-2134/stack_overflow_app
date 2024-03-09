import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:stack_overflow_app/helper/nav_helper.dart';
import 'package:stack_overflow_app/helper/utils.dart';
import 'package:stack_overflow_app/models/item_model.dart';
import 'package:stack_overflow_app/ui/widget/answer_text.dart';

/// A widget to display details of a Stack Overflow item.
class DetailsWidget extends StatelessWidget {
  /// Callback function to handle chip taps.
  final void Function(String tag)? onChipTap;

  /// Constraints for the widget.
  final BoxConstraints constraints;

  /// The Stack Overflow item to display details of.
  final Items? item;

  /// Constructor for the [DetailsWidget].
  const DetailsWidget({
    Key? key,
    required this.onChipTap,
    required this.constraints,
    this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        openScreen(
          webViewScreen,
          args: LinkedHashMap.from({'url': item?.link ?? ''}),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(10),
        color: Colors.white,
        elevation: 2,
        shadowColor: Theme.of(context).primaryColor.withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Theme.of(context).primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: constraints.constrainWidth() > 600
              ? Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Text(
                            '${item?.score ?? 0}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        AnswerText(
                          count: item?.answerCount ?? 0,
                          isAnswered: item?.isAnswered ?? false,
                        ),
                        Text(
                          '${item?.viewCount ?? 0} views',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item?.title ?? '',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Wrap(
                            children: (item?.tags ?? [])
                                .map(
                                  (element) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        onChipTap?.call(element);
                                      },
                                      child: Chip(
                                        label: Text(
                                          element,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall,
                                        ),
                                        labelPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 5,
                                        ),
                                        elevation: 2,
                                        shadowColor: Colors.grey.shade100,
                                        backgroundColor: Colors.lightBlueAccent,
                                        side: BorderSide.none,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                minRadius: 10,
                                maxRadius: 15,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    item?.owner?.profileImage ?? '',
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace? stackTrace) {
                                      return const Text('😢');
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Text(
                                    item?.owner?.displayName ?? '',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                ),
                              ),
                              Text(
                                'asked ${formatDurationFromTimestamp(item?.creationDate ?? 0)}',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item?.title ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Wrap(
                          children: (item?.tags ?? [])
                              .map(
                                (element) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: InkWell(
                                    onTap: () {
                                      onChipTap?.call(element);
                                    },
                                    child: Chip(
                                      label: Text(
                                        element,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      elevation: 2,
                                      shadowColor: Colors.grey.shade100,
                                      backgroundColor: Colors.lightBlueAccent,
                                      side: BorderSide.none,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              minRadius: 10,
                              maxRadius: 15,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  item?.owner?.profileImage ?? '',
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return const Text('😢');
                                  },
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        value: loadingProgress
                                                    .expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Text(
                                  item?.owner?.displayName ?? '',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                              ),
                            ),
                            Text(
                              'asked ${formatDurationFromTimestamp(item?.creationDate ?? 0)}',
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: Text(
                            '${item?.score ?? 0}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        AnswerText(
                          count: item?.answerCount ?? 0,
                          isAnswered: item?.isAnswered ?? false,
                        ),
                        Text(
                          '${item?.viewCount ?? 0} views',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
