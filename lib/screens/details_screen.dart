import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/details_widget.dart';
import '../provider/helper_provider.dart';
import '../widgets/error_widget.dart' as error;

class DetailsScreen extends ConsumerWidget {

  const DetailsScreen({super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final [data, image]= ref.watch(dataProvider);
    return Scaffold(
      body : data['cod'] == 200
          ? DetailsWidget(data: data, image: image,)
          : error.ErrorWidget(data: data)
    );
  }

}
