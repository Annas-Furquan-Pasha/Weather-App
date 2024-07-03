import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/provider/helper_provider.dart';

import './card_builder.dart';

class DetailsWidget extends ConsumerStatefulWidget {
  const DetailsWidget({super.key, required this.data, required this.image});

  @override
  ConsumerState<DetailsWidget> createState() => _DetailsWidgetState();

  final dynamic data;
  final Image image;

}

class _DetailsWidgetState extends ConsumerState<DetailsWidget> {

  bool _isOnRefresh = false;
  void onRefresh() async {
    setState(() {
      _isOnRefresh = true;
    });
   await ref.read(dataProvider.notifier).addWeatherDetails(widget.data['name']);
   setState(() {
     _isOnRefresh = false;
   });
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: widget.image ,
            ),
            const SizedBox(height: 10,),
            Text('${widget.data['name']}'.toUpperCase(), style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: 46,
            ),),
            const SizedBox(height: 20,),
            CardBuilder(data: 'Temperature : ${widget.data['temperature']} \u00b0C', color: Colors.redAccent, icon: const Icon(Icons.thermostat)),
            const SizedBox(height: 20,),
            CardBuilder(data: 'Wind Speed : ${widget.data['wind speed']} m/s ', color: Colors.lightGreen, icon: const Icon(Icons.air)),
            const SizedBox(height: 20,),
            CardBuilder(data: 'Humidity : ${widget.data['humidity']}%', color: Colors.amber, icon: const Icon(Icons.hot_tub)),
            const SizedBox(height: 20,),
            CardBuilder(data: 'Weather Condition : ${widget.data['condition']}', color: Colors.lightBlue, icon: const Icon(Icons.cloud)),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _isOnRefresh
                    ? const CircularProgressIndicator()
                    : ElevatedButton.icon(onPressed:  onRefresh,
                            label: Text('Refresh', style: Theme.of(context).textTheme.bodyMedium,), icon: const Icon(Icons.refresh),),
                ElevatedButton.icon(onPressed: () {
                  Navigator.of(context).pop();
                }, label: Text('Back', style: Theme.of(context).textTheme.bodyMedium,), icon: const Icon(Icons.arrow_back),)
              ],
            )
          ],
        ),
      ),
    );
  }
}


// RowBuilder(title: 'City Name', detail: data['name']),
// RowBuilder(title: 'Temperature', detail: data['temperature']),
// RowBuilder(title: 'Humidity', detail: data['humidity']),
// RowBuilder(title: 'Wind Speed', detail: data['wind speed']),
// RowBuilder(title: 'Weather Condition', detail: data['condition']),