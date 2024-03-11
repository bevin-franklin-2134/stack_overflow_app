import 'package:flutter/material.dart';

/// A widget to display the answer count.
class AnswerText extends StatelessWidget {
  /// The number of answers.
  final int count;

  /// A flag indicating if the question is answered.
  final bool isAnswered;

  /// Constructor for the [AnswerText] widget.
  const AnswerText({super.key, required this.count, required this.isAnswered});

  @override
  Widget build(BuildContext context) {
    return count > 0 && isAnswered
        ? Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 15,
                ),
                const SizedBox(width: 5),
                Text(
                  '$count answers',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.white),
                ),
              ],
            ),
          )
        : count > 0
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.green),
                ),
                child: Text(
                  '$count answers',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.green),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$count answers',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              );
  }
}
