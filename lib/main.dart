import 'package:flutter/material.dart';

void main() => runApp(const FitFlowApp());

class FitFlowApp extends StatelessWidget {
  const FitFlowApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'FitFlow',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4F46E5),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      );
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tab = 0;
  bool _workoutDone = false;

  static const _titles = ['Today', 'Plan', 'Community', 'Nutrition'];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _TodayPage(
          done: _workoutDone,
          onComplete: () => setState(() => _workoutDone = true)),
      const _PlanPage(),
      const _CommunityPage(),
      const _NutritionPage(),
    ];
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_tab]), centerTitle: false),
      body: SafeArea(child: pages[_tab]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (value) => setState(() => _tab = value),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Today'),
          NavigationDestination(
              icon: Icon(Icons.auto_awesome_outlined),
              selectedIcon: Icon(Icons.auto_awesome),
              label: 'Plan'),
          NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Community'),
          NavigationDestination(
              icon: Icon(Icons.restaurant_outlined),
              selectedIcon: Icon(Icons.restaurant),
              label: 'Nutrition'),
        ],
      ),
    );
  }
}

class _TodayPage extends StatelessWidget {
  const _TodayPage({required this.done, required this.onComplete});
  final bool done;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Good morning, Alex',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          const Text('Your plan adapts to your schedule and energy today.'),
          const SizedBox(height: 22),
          Card(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(Icons.auto_awesome,
                          color: Theme.of(context).colorScheme.primary),
                      const SizedBox(width: 8),
                      Text('AI DAILY FLOW',
                          style: Theme.of(context).textTheme.labelLarge),
                    ]),
                    const SizedBox(height: 14),
                    Text('Strength express',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    const Text(
                        '24 min - Moderate - Built around your 30-minute gap'),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      onPressed: done ? null : onComplete,
                      icon: Icon(done ? Icons.check : Icons.play_arrow),
                      label: Text(done ? 'Workout completed' : 'Start workout'),
                    ),
                  ]),
            ),
          ),
          const SizedBox(height: 22),
          Text('This week', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 12),
          const Row(children: [
            Expanded(
                child: _Metric(
                    icon: Icons.local_fire_department_outlined,
                    value: '1,840',
                    label: 'cal burned')),
            SizedBox(width: 12),
            Expanded(
                child: _Metric(
                    icon: Icons.bolt_outlined,
                    value: '3/4',
                    label: 'workouts')),
          ]),
          const SizedBox(height: 22),
          Text('Keep your streak alive',
              style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          const Text(
              'You and 12 others are taking part in the October Move More challenge.'),
        ],
      );
}

class _Metric extends StatelessWidget {
  const _Metric({required this.icon, required this.value, required this.label});
  final IconData icon;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(16),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icon),
            const SizedBox(height: 12),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold)),
            Text(label)
          ])));
}

class _PlanPage extends StatelessWidget {
  const _PlanPage();
  @override
  Widget build(BuildContext context) =>
      ListView(padding: const EdgeInsets.all(20), children: [
        Text('Adaptive for your week',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
            'Adjust a suggestion anytime. FitFlow uses your feedback, availability, and preferences.'),
        const SizedBox(height: 20),
        ...[
          'Mon - Full body strength',
          'Wed - Mobility reset',
          'Fri - Cardio intervals'
        ].map((item) => Card(
            child: ListTile(
                leading: const Icon(Icons.fitness_center),
                title: Text(item),
                subtitle: const Text('Suggested by your AI coach'),
                trailing: const Icon(Icons.chevron_right)))),
      ]);
}

class _CommunityPage extends StatelessWidget {
  const _CommunityPage();
  @override
  Widget build(BuildContext context) =>
      ListView(padding: const EdgeInsets.all(20), children: [
        Text('Your circles',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Share progress with people you choose.'),
        const SizedBox(height: 16),
        const Card(
            child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.groups)),
                title: Text('Morning Movers'),
                subtitle: Text('12 members - October Move More'))),
        const Card(
            child: ListTile(
                leading: CircleAvatar(child: Icon(Icons.emoji_events)),
                title: Text('Nadia completed a 7-day streak'),
                subtitle: Text('Give encouragement'))),
      ]);
}

class _NutritionPage extends StatelessWidget {
  const _NutritionPage();
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Nutrition, simplified',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Log a meal with a photo or add it manually.'),
        const Spacer(),
        Center(
            child: FilledButton.icon(
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text(
                            'Food recognition will be available in the next build.'))),
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Scan a meal'))),
        const SizedBox(height: 28),
      ]));
}
