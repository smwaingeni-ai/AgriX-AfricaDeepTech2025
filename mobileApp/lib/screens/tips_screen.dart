import 'package:flutter/material.dart';

class TipsScreen extends StatelessWidget {
  const TipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Soil', 'Crops', 'Livestock'];

    final Map<String, List<String>> tips = {
      'Soil': [
        '🪱 Rotate crops annually to improve soil nutrients.',
        '🧪 Test soil pH regularly to ensure optimal conditions.',
        '🌱 Use compost to boost soil fertility naturally.',
      ],
      'Crops': [
        '🌾 Water crops early in the morning or late evening to reduce evaporation.',
        '🛡️ Use disease-resistant crop varieties where available.',
        '👨‍🌾 Practice intercropping to reduce pest attacks.',
      ],
      'Livestock': [
        '🐄 Always provide clean drinking water to animals.',
        '💉 Vaccinate livestock regularly to prevent disease outbreaks.',
        '🌿 Ensure proper grazing rotation to prevent pasture degradation.',
      ],
    };

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agri Tips'),
          bottom: TabBar(
            tabs: tabs.map((e) => Tab(text: e)).toList(),
          ),
        ),
        body: TabBarView(
          children: tabs.map((category) {
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tips[category]!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(tips[category]![index]),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
