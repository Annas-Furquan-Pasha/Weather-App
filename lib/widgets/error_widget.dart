import 'package:flutter/material.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({super.key, required this.data});

  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(flex: 2,child: Container(),),
            Text('${data['cod']} !!!', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 46),),
            const SizedBox(height: 5,),
            const Text('Error'),
            const SizedBox(height: 24,),
            Text(data['message'], style: Theme.of(context).textTheme.bodyLarge,),
            const SizedBox(height: 24,),
            ElevatedButton.icon(onPressed: () {
              Navigator.of(context).pop();
            }, label: Text('Search another city', style: Theme.of(context).textTheme.bodyMedium,), icon: const Icon(Icons.arrow_back),),
            Flexible(flex: 2,child: Container(),),
          ],
        ),
      ),
    );
  }
}
