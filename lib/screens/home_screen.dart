import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './details_screen.dart';
import '../provider/helper_provider.dart';
import '../widgets/recent.dart';
import '../widgets/error_widget.dart' as error;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController _controller = TextEditingController();
  final _focusNode = FocusNode();
  late Future<void> _recentFuture;

  @override
  void initState() {
    _recentFuture = ref.read(recentProvider.notifier).loadRecent();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }
  bool _isGetting = false;

  @override
  Widget build(BuildContext context) {

    final border = OutlineInputBorder(
      borderSide: Divider.createBorderSide(context),
      borderRadius: BorderRadius.circular(20),
    );

    void validation(String city) async {
      if(city.isEmpty) {
        return ;
      }

      setState(() {
        _isGetting = true;
      });

      await ref.read(dataProvider.notifier).addWeatherDetails(city);

      setState(() {
        _isGetting = false;
      });

      ref.read(recentProvider.notifier).addRecent(city);

      _controller.clear();
      _focusNode.unfocus();
       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DetailsScreen()),);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 70,),
            SizedBox(
                width: 130,
                height: 130,
                child: Image.asset('assets/ic_weather.png', fit: BoxFit.cover, height: double.infinity, width: double.infinity,),
            ),
            const SizedBox(height: 50,),
            TextField(
              focusNode: _focusNode,
              autofocus: false,
              controller: _controller,
              style: Theme.of(context).textTheme.titleLarge,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () => validation(_controller.text.toString()),
                  icon: const Icon(Icons.search),
                ),
                hintText: 'Enter Location',
                border: border,
                focusedBorder: border,
                enabledBorder: border,
                filled: true,
                contentPadding: const EdgeInsets.all(10),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 5,),
            if(_isGetting) const CircularProgressIndicator(),
            const SizedBox(height: 25,),
            FutureBuilder(future: _recentFuture,
              builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
                  ? const Center(child: CircularProgressIndicator(),)
                  : Recent(text: _controller),)
          ],
        ),
      ),
    );
  }
}


// GestureDetector(
// onTap: () {
// validation();
// },
// child: Container(
// width: double.infinity,
// alignment: Alignment.center,
// padding: const EdgeInsets.symmetric(vertical: 8),
// decoration: ShapeDecoration(
// shape: const RoundedRectangleBorder(
// borderRadius: BorderRadius.all(Radius.circular(20)),
// ),
// color: Theme.of(context).colorScheme.primary,
// ),
// child: _isGetting ? const CircularProgressIndicator(color: Colors.black,) : const Text('submit', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
// ),
// ),


// icon : http://openweathermap.org/img/w/10d.png
// weather : http://api.openweathermap.org/data/2.5/weather?appid=d1f540e7e28df7f2e396f4a76ba682b3&q=hyderabad&units=metric