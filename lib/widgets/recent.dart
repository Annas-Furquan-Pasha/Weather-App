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
            Text('Recent', style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.left,),
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
                                  IconButton(onPressed: () {}, icon: const Icon(Icons.history)),
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

