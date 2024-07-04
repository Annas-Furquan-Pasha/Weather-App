import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/helper_provider.dart';

class Recent extends ConsumerStatefulWidget {
  const Recent({super.key, required this.text});

  final TextEditingController text;

  @override
  ConsumerState<Recent> createState() => _RecentState();
}

class _RecentState extends ConsumerState<Recent> {

  @override
  Widget build(BuildContext context) {
    final recent = ref.watch(recentProvider);

    return recent.isNotEmpty ? Expanded(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left,),
                GestureDetector(
                  onTap: () {
                    ref.read(recentProvider.notifier).clear();
                  },
                  child: Text('clear', style: Theme.of(context).textTheme.bodyMedium,),
                )
              ],
            ),
            const SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                  itemCount: recent.length,
                  itemBuilder: (ctx, index) => GestureDetector(
                    onTap: () {
                      widget.text.text = recent[index];
                    },
                    child: Card(
                      elevation: 5,
                      child: Container(
                        height: 50,
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.history),
                                  const SizedBox(width: 8,),
                                  Text(recent[index], style: Theme.of(context).textTheme.bodyMedium,),
                                ],
                              ),
                              IconButton(onPressed: () {ref.read(recentProvider.notifier).deleteRecent(recent[index]); setState(() {});},
                                  icon: const Icon(Icons.cancel, color: Colors.red,))
                            ],
                          )),
                    ),
                  )
              ),
            ),
          ],
        )
    ) : Container();
  }
}

