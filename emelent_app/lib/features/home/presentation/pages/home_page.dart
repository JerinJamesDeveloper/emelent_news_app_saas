// /// Home Page
// ///
// /// Main page for home feature.
// library;

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/di/injection_container.dart';
// import '../bloc/home_bloc.dart';
// import '../bloc/home_event.dart';
// import '../bloc/home_state.dart';
// import '../widgets/home_list_widget.dart';

// /// Home page widget
// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<HomeBloc>()
//         ..add(const HomeListLoadRequested()),
//       child: const HomeView(),
//     );
//   }
// }

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               context.read<HomeBloc>().add(
//                 const HomeRefreshRequested(),
//               );
//             },
//           ),
//         ],
//       ),
//       body: BlocConsumer<HomeBloc, HomeState>(
//         listener: (context, state) {
//           if (state is HomeError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.red,
//                 action: SnackBarAction(
//                   label: 'Dismiss',
//                   textColor: Colors.white,
//                   onPressed: () {
//                     context.read<HomeBloc>().add(
//                       const HomeErrorCleared(),
//                     );
//                   },
//                 ),
//               ),
//             );
//           }
//           if (state is HomeOperationSuccess) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//                 backgroundColor: Colors.green,
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return switch (state) {
//             HomeInitial() => const _InitialView(),
//             HomeLoading() => const _LoadingView(),
//             HomeListLoaded(:final homes) =>
//               HomeListWidget(homes: homes),
//             HomeOperating(:final homes) =>
//               HomeListWidget(homes: homes, isOperating: true),
//             HomeOperationSuccess(:final homes) =>
//               HomeListWidget(homes: homes),
//             HomeError(:final homes) =>
//               homes != null && homes.isNotEmpty
//                   ? HomeListWidget(homes: homes)
//                   : const _ErrorView(),
//             _ => const SizedBox(),
//           };
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showCreateDialog(context),
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   void _showCreateDialog(BuildContext context) {
//     final nameController = TextEditingController();
//     final descriptionController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (dialogContext) => AlertDialog(
//         title: const Text('Create Home'),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 hintText: 'Enter name',
//               ),
//             ),
//             const SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 hintText: 'Enter description (optional)',
//               ),
//               maxLines: 3,
//             ),
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(dialogContext).pop(),
//             child: const Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (nameController.text.trim().isNotEmpty) {
//                 context.read<HomeBloc>().add(
//                   HomeCreateRequested(
//                     name: nameController.text.trim(),
//                     description: descriptionController.text.trim().isEmpty
//                         ? null
//                         : descriptionController.text.trim(),
//                   ),
//                 );
//                 Navigator.of(dialogContext).pop();
//               }
//             },
//             child: const Text('Create'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _InitialView extends StatelessWidget {
//   const _InitialView();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: Text('Press refresh to load data'),
//     );
//   }
// }

// class _LoadingView extends StatelessWidget {
//   const _LoadingView();

//   @override
//   Widget build(BuildContext context) {
//     return const Center(
//       child: CircularProgressIndicator(),
//     );
//   }
// }

// class _ErrorView extends StatelessWidget {
//   const _ErrorView();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Icon(Icons.error_outline, size: 64, color: Colors.red),
//           const SizedBox(height: 16),
//           const Text('Failed to load data'),
//           const SizedBox(height: 16),
//           ElevatedButton(
//             onPressed: () {
//               context.read<HomeBloc>().add(
//                 const HomeListLoadRequested(),
//               );
//             },
//             child: const Text('Retry'),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:emelent_app/core/di/injection_container.dart';
import 'package:emelent_app/features/home/presentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';

// void main() {
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.dark,
//     ),
//   );
//   runApp(const EmelentaeApp());
// }

// ─────────────────────────────────────────────
//  Design Tokens
// ─────────────────────────────────────────────
class ET {
  // Dark editorial palette
  static const bg = Color(0xFF0B0E14);
  static const bgCard = Color(0xFF111620);
  static const bgCardAlt = Color(0xFF131825);
  static const bgSurface = Color(0xFF1A2030);
  static const bgGlass = Color(0xFF1E2535);

  static const borderSubtle = Color(0xFF232B3A);
  static const borderMid = Color(0xFF2E3A50);
  static const borderStrong = Color(0xFF3D4F6A);

  static const gold = Color(0xFFD4A853);
  static const goldLight = Color(0xFFE8C878);
  static const goldDim = Color(0xFF7A5E2A);
  static const goldSurface = Color(0xFF1E1A0F);

  static const ink = Color(0xFFF0F2F5);
  static const inkSecondary = Color(0xFFABB4C4);
  static const inkTertiary = Color(0xFF5C6B82);
  static const inkMuted = Color(0xFF3A4556);

  static const accentBlue = Color(0xFF2D7DD2);
  static const accentBlueDim = Color(0xFF1A3D6B);
  static const accentBlueSurface = Color(0xFF0D1A2E);

  static const verified = Color(0xFF4AC97E);
  static const verifiedSurface = Color(0xFF0D2018);

  static const positive = Color(0xFF3DBD78);
  static const positiveSurface = Color(0xFF0D1F15);

  static const caution = Color(0xFFE8A532);
  static const cautionSurface = Color(0xFF1E1508);

  static const dispute = Color(0xFFD45C5C);
  static const disputeSurface = Color(0xFF200D0D);

  static const neutral = Color(0xFF7B8FB0);
  static const neutralSurface = Color(0xFF121820);

  // Spacing
  static const p4 = 4.0;
  static const p6 = 6.0;
  static const p8 = 8.0;
  static const p10 = 10.0;
  static const p12 = 12.0;
  static const p14 = 14.0;
  static const p16 = 16.0;
  static const p20 = 20.0;
  static const p24 = 24.0;
  static const p28 = 28.0;
  static const p32 = 32.0;

  // Typography
  static TextStyle serif(double size, {FontWeight w = FontWeight.w700, Color color = ink}) =>
      TextStyle(fontFamily: 'Georgia', fontSize: size, fontWeight: w, color: color, height: 1.25, letterSpacing: -0.4);

  static TextStyle sans(double size, {FontWeight w = FontWeight.w400, Color color = ink}) =>
      TextStyle(fontFamily: 'Helvetica Neue', fontSize: size, fontWeight: w, color: color, height: 1.5, letterSpacing: -0.1);

  static TextStyle mono(double size, {Color color = inkTertiary, FontWeight w = FontWeight.w400}) =>
      TextStyle(fontFamily: 'Courier New', fontSize: size, color: color, fontWeight: w, letterSpacing: 0.5, height: 1.3);

  static TextStyle label(double size, {Color color = inkTertiary}) =>
      TextStyle(fontFamily: 'Helvetica Neue', fontSize: size, color: color, fontWeight: FontWeight.w600, letterSpacing: 1.2, height: 1.2);
}

// ─────────────────────────────────────────────
//  Mock Data
// ─────────────────────────────────────────────

// Story sources for horizontal strip
final List<Map<String, dynamic>> _stories = [
  {'initials': 'FT', 'color': Color(0xFF8B2F2F), 'label': 'Finance', 'live': true},
  {'initials': 'GP', 'color': Color(0xFF1A3A5C), 'label': 'Geopolit.', 'live': false},
  {'initials': 'SC', 'color': Color(0xFF1A4A3A), 'label': 'Science', 'live': true},
  {'initials': 'LW', 'color': Color(0xFF4A2D6B), 'label': 'Law', 'live': false},
  {'initials': 'MK', 'color': Color(0xFF4A3A1A), 'label': 'Markets', 'live': false},
  {'initials': 'TE', 'color': Color(0xFF1A3A4A), 'label': 'Tech', 'live': false},
];

// ─────────────────────────────────────────────
//  Mock Data
// ─────────────────────────────────────────────
final List<Map<String, dynamic>> _feed = [
  {
    'username': 'Global Policy Watch',
    'handle': '@gpwatch',
    'initials': 'GP',
    'avatarColor': Color(0xFF1A3A5C),
    'avatarGradient': [Color(0xFF1A3A5C), Color(0xFF2B5F8E)],
    'verified': true,
    'timestamp': '4m',
    'category': 'GEOPOLITICS',
    'categoryColor': ET.accentBlue,
    'categoryBg': ET.accentBlueSurface,
    'headline': 'G7 finance ministers reach preliminary accord on sovereign debt restructuring framework',
    'body': 'A landmark agreement addressing the compounding debt burdens of 34 low-income nations was drafted in Geneva on Thursday, with implementation contingent on ratification by member legislatures. Senior officials cited the Zambia case as a template for multi-creditor coordination.',
    'hasImage': true,
    'imageGradient': [Color(0xFF1A2A3E), Color(0xFF0D1822)],
    'imageLabel': 'Geneva Summit · Feb 2026',
    'sourceUrl': 'reuters.com',
    'sourceTitle': 'Reuters World',
    'credibility': 94,
    'credibilityLabel': 'HIGH CREDIBILITY',
    'credibilityColor': ET.positive,
    'credibilitySurface': ET.positiveSurface,
    'status': 'Verified · 3 independent sources',
    'flagged': false,
    'evalCounts': {'Credible': 312, 'Context': 47, 'Disputed': 8},
    'bookmarked': true,
    'views': '18.4K',
    'shares': '2.1K',
  },
  {
    'username': 'MarketSignal',
    'handle': '@mktsignal',
    'initials': 'MS',
    'avatarColor': Color(0xFF2D4A6B),
    'avatarGradient': [Color(0xFF2D4A6B), Color(0xFF4A6B8B)],
    'verified': true,
    'timestamp': '18m',
    'category': 'FINANCE',
    'categoryColor': ET.gold,
    'categoryBg': ET.goldSurface,
    'headline': 'Federal Reserve signals revised rate trajectory amid persistent core inflation readings',
    'body': 'Minutes from the latest FOMC meeting reveal internal debate over the timing of the next adjustment cycle, with dissenting voices citing labor market resilience as a complicating variable.',
    'hasImage': false,
    'sourceUrl': 'ft.com',
    'sourceTitle': 'Financial Times',
    'credibility': 88,
    'credibilityLabel': 'CREDIBLE',
    'credibilityColor': ET.positive,
    'credibilitySurface': ET.positiveSurface,
    'status': 'Cross-referenced · FOMC docs',
    'flagged': false,
    'evalCounts': {'Credible': 541, 'Context': 89, 'Disputed': 21},
    'bookmarked': false,
    'views': '31.2K',
    'shares': '4.8K',
  },
  {
    'username': 'ScienceDesk',
    'handle': '@sciencedesk',
    'initials': 'SD',
    'avatarColor': Color(0xFF1A4A3A),
    'avatarGradient': [Color(0xFF1A4A3A), Color(0xFF2D7A5C)],
    'verified': false,
    'timestamp': '1h',
    'category': 'SCIENCE',
    'categoryColor': ET.positive,
    'categoryBg': ET.positiveSurface,
    'headline': 'Preprint: 34% efficiency gain in solid-state battery architecture — peer review pending',
    'body': 'Researchers at Kyoto University submitted findings to arXiv suggesting a novel lithium-ceramic interface approach may dramatically reduce charge cycle degradation. Independent replication not yet confirmed.',
    'hasImage': false,
    'sourceUrl': 'arxiv.org',
    'sourceTitle': 'arXiv Preprint',
    'credibility': 61,
    'credibilityLabel': 'UNVERIFIED',
    'credibilityColor': ET.caution,
    'credibilitySurface': ET.cautionSurface,
    'status': 'Awaiting peer review',
    'flagged': true,
    'flagMessage': 'Preprint — not yet peer reviewed',
    'evalCounts': {'Credible': 98, 'Context': 203, 'Disputed': 44},
    'bookmarked': false,
    'views': '9.7K',
    'shares': '891',
  },
  {
    'username': 'Institutional Analysis',
    'handle': '@instanalysis',
    'initials': 'IA',
    'avatarColor': Color(0xFF4A2D6B),
    'avatarGradient': [Color(0xFF4A2D6B), Color(0xFF6B4A8B)],
    'verified': true,
    'timestamp': '2h',
    'category': 'POLICY',
    'categoryColor': Color(0xFFB07AD4),
    'categoryBg': Color(0xFF1A0F2E),
    'headline': 'European Parliament advances landmark AI liability directive to final committee stage',
    'body': 'The proposed regulation would assign mandatory disclosure obligations to foundation model developers operating in EU markets, with enforcement mechanisms tied to revenue-based fines.',
    'hasImage': true,
    'imageGradient': [Color(0xFF1E1530), Color(0xFF0F0B1E)],
    'imageLabel': 'European Parliament · Brussels',
    'sourceUrl': 'europarl.europa.eu',
    'sourceTitle': 'European Parliament',
    'credibility': 97,
    'credibilityLabel': 'PRIMARY SOURCE',
    'credibilityColor': ET.positive,
    'credibilitySurface': ET.positiveSurface,
    'status': 'Official record confirmed',
    'flagged': false,
    'evalCounts': {'Credible': 724, 'Context': 62, 'Disputed': 5},
    'bookmarked': true,
    'views': '44.1K',
    'shares': '7.3K',
  },
];

// // ─────────────────────────────────────────────
// //  App Root
// // ─────────────────────────────────────────────
// class EmelentaeApp extends StatelessWidget {
//   const EmelentaeApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'EMELENTAE',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: ET.bg,
//         colorScheme: const ColorScheme.light(
//           primary: ET.accent,
//           surface: ET.surface,
//         ),
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//       ),
//       home: const HomeScreen(),
//     );
//   }
// }

// ─────────────────────────────────────────────
//  Home Screen
// ─────────────────────────────────────────────
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HomeBloc>()
        ..add(const HomeListLoadRequested()),
      child: const HomeView(),
    );
  }
}
// ─────────────────────────────────────────────
//  Home Page
// ─────────────────────────────────────────────
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _navIndex = 0;
  final _scrollCtrl = ScrollController();

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ET.bg,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            CustomScrollView(
              controller: _scrollCtrl,
              physics: const BouncingScrollPhysics(),
              slivers: [
                // Top Nav
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _NavBarDelegate(),
                ),
                // Metrics Strip
                SliverToBoxAdapter(child: _MetricsStrip()),
                // Story Row
                SliverToBoxAdapter(child: _StoryRow()),
                // Section Header
                SliverToBoxAdapter(child: _FeedSectionHeader()),
                // Feed Cards
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (ctx, i) => Padding(
                      padding: EdgeInsets.fromLTRB(ET.p16, i == 0 ? ET.p4 : 0, ET.p16, ET.p10),
                      child: _FeedCard(data: _feed[i]),
                    ),
                    childCount: _feed.length,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 100)),
              ],
            ),
            // FAB
            Positioned(
              right: ET.p20,
              bottom: 32,
              child: _Fab(),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Nav Bar
// ─────────────────────────────────────────────
class _NavBarDelegate extends SliverPersistentHeaderDelegate {
  @override double get minExtent => 62;
  @override double get maxExtent => 62;
  @override bool shouldRebuild(_NavBarDelegate old) => false;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: BoxDecoration(
        color: ET.bg,
        border: Border(bottom: BorderSide(color: ET.borderSubtle, width: 0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: ET.p20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Logo lockup
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (b) => const LinearGradient(
                  colors: [ET.goldLight, ET.gold],
                ).createShader(b),
                child: Text(
                  'EMELENTAE',
                  style: ET.serif(17, w: FontWeight.w800, color: Colors.white)
                      .copyWith(letterSpacing: 3.5),
                ),
              ),
              Text(
                'INTELLIGENCE NETWORK',
                style: ET.label(7, color: ET.inkMuted).copyWith(letterSpacing: 2.2),
              ),
            ],
          ),
          const Spacer(),
          // Live badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1A1A).withOpacity(0.3),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFF8B1A1A), width: 0.5),
            ),
            child: Row(
              children: [
                Container(
                  width: 5, height: 5,
                  decoration: const BoxDecoration(color: Color(0xFFE05252), shape: BoxShape.circle),
                ),
                const SizedBox(width: 4),
                Text('LIVE', style: ET.label(7.5, color: Color(0xFFE05252)).copyWith(letterSpacing: 1.4)),
              ],
            ),
          ),
          const SizedBox(width: ET.p14),
          _NavIconBtn(icon: Icons.search_rounded),
          const SizedBox(width: ET.p14),
          _NavIconBadge(icon: Icons.notifications_none_rounded, count: 3),
          const SizedBox(width: ET.p14),
          _AvatarRing(initials: 'JR', color: ET.accentBlue, size: 30, hasRing: true),
        ],
      ),
    );
  }
}

class _NavIconBtn extends StatelessWidget {
  final IconData icon;
  const _NavIconBtn({required this.icon});
  @override
  Widget build(BuildContext context) => Icon(icon, size: 20, color: ET.inkSecondary);
}

class _NavIconBadge extends StatelessWidget {
  final IconData icon;
  final int count;
  const _NavIconBadge({required this.icon, required this.count});
  @override
  Widget build(BuildContext context) => Stack(
    clipBehavior: Clip.none,
    children: [
      Icon(icon, size: 20, color: ET.inkSecondary),
      Positioned(
        top: -3, right: -3,
        child: Container(
          width: 13, height: 13,
          decoration: const BoxDecoration(color: ET.gold, shape: BoxShape.circle),
          child: Center(child: Text('$count', style: ET.mono(7, color: ET.bg, w: FontWeight.w700))),
        ),
      ),
    ],
  );
}

class _AvatarRing extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;
  final bool hasRing;
  const _AvatarRing({required this.initials, required this.color, required this.size, this.hasRing = false});

  @override
  Widget build(BuildContext context) => Container(
    width: size + (hasRing ? 4 : 0),
    height: size + (hasRing ? 4 : 0),
    decoration: hasRing ? BoxDecoration(
      shape: BoxShape.circle,
      gradient: const LinearGradient(
        colors: [ET.goldLight, ET.gold, ET.goldDim],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ) : null,
    padding: hasRing ? const EdgeInsets.all(1.5) : EdgeInsets.zero,
    child: Container(
      decoration: BoxDecoration(color: ET.bg, shape: BoxShape.circle),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text(initials, style: ET.sans(size * 0.30, w: FontWeight.w700, color: Colors.white))),
      ),
    ),
  );
}

// ─────────────────────────────────────────────
//  Metrics Strip
// ─────────────────────────────────────────────
class _MetricsStrip extends StatelessWidget {
  final _metrics = const [
    {'label': 'STORIES', 'value': '1,847', 'delta': '+23'},
    {'label': 'VERIFIED', 'value': '94.2%', 'delta': '+0.4'},
    {'label': 'SOURCES', 'value': '312', 'delta': '+7'},
    {'label': 'AVG SCORE', 'value': '87.4', 'delta': '+1.2'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(ET.p16, ET.p12, ET.p16, 0),
      padding: const EdgeInsets.symmetric(horizontal: ET.p16, vertical: ET.p12),
      decoration: BoxDecoration(
        color: ET.bgSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: ET.borderSubtle),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF1A2030), Color(0xFF131825)],
        ),
      ),
      child: Row(
        children: List.generate(_metrics.length * 2 - 1, (i) {
          if (i.isOdd) {
            return Container(
              width: 1, height: 30,
              color: ET.borderSubtle,
              margin: const EdgeInsets.symmetric(horizontal: ET.p12),
            );
          }
          final m = _metrics[i ~/ 2];
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(m['label']!, style: ET.label(7.5, color: ET.inkMuted).copyWith(letterSpacing: 1.0)),
                const SizedBox(height: 3),
                Text(m['value']!, style: ET.serif(15, w: FontWeight.w800, color: ET.ink)),
                const SizedBox(height: 2),
                Text(
                  m['delta']!,
                  style: ET.mono(8.5, color: ET.positive),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Story Row (social-style)
// ─────────────────────────────────────────────
class _StoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(ET.p16, ET.p14, ET.p16, ET.p4),
        itemCount: _stories.length + 1,
        itemBuilder: (ctx, i) {
          if (i == 0) return _StoryAddBtn();
          final s = _stories[i - 1];
          return _StoryItem(data: s);
        },
      ),
    );
  }
}

class _StoryAddBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: ET.p12),
    child: Column(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: ET.bgSurface,
            border: Border.all(color: ET.borderMid),
          ),
          child: const Icon(Icons.add_rounded, color: ET.inkSecondary, size: 20),
        ),
        const SizedBox(height: 5),
        Text('Add Story', style: ET.mono(8.5, color: ET.inkTertiary)),
      ],
    ),
  );
}

class _StoryItem extends StatelessWidget {
  final Map<String, dynamic> data;
  const _StoryItem({required this.data});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(right: ET.p12),
    child: Column(
      children: [
        Container(
          width: 52, height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: data['live']
                ? const LinearGradient(colors: [Color(0xFFE05252), Color(0xFFB03030)], begin: Alignment.topLeft, end: Alignment.bottomRight)
                : const LinearGradient(colors: [ET.gold, ET.goldDim], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: const BoxDecoration(color: ET.bg, shape: BoxShape.circle),
            padding: const EdgeInsets.all(2),
            child: Container(
              decoration: BoxDecoration(color: data['color'] as Color, shape: BoxShape.circle),
              child: Center(
                child: Text(data['initials'] as String, style: ET.sans(13, w: FontWeight.w700, color: Colors.white)),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(data['label'] as String, style: ET.mono(8.5, color: ET.inkSecondary)),
        if (data['live'] as bool)
          Container(
            margin: const EdgeInsets.only(top: 2),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            decoration: BoxDecoration(
              color: const Color(0xFF8B1A1A).withOpacity(0.4),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text('LIVE', style: ET.label(6.5, color: Color(0xFFE05252)).copyWith(letterSpacing: 1.0)),
          ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  Feed Section Header
// ─────────────────────────────────────────────
class _FeedSectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(ET.p20, ET.p8, ET.p20, ET.p6),
    child: Row(
      children: [
        Container(width: 3, height: 14, color: ET.gold, margin: const EdgeInsets.only(right: ET.p8)),
        Text('FOR YOU', style: ET.label(11, color: ET.ink).copyWith(letterSpacing: 1.8)),
        const SizedBox(width: ET.p8),
        Text('· Verified First', style: ET.mono(9.5, color: ET.inkTertiary)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: ET.bgSurface,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: ET.borderSubtle),
          ),
          child: Row(
            children: [
              Text('FILTER', style: ET.label(8, color: ET.inkSecondary).copyWith(letterSpacing: 1.0)),
              const SizedBox(width: 4),
              const Icon(Icons.tune_rounded, size: 12, color: ET.inkSecondary),
            ],
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────
//  Feed Card
// ─────────────────────────────────────────────
class _FeedCard extends StatefulWidget {
  final Map<String, dynamic> data;
  const _FeedCard({required this.data});

  @override
  State<_FeedCard> createState() => _FeedCardState();
}

class _FeedCardState extends State<_FeedCard> with SingleTickerProviderStateMixin {
  String? _selected;
  bool _expanded = false;
  bool _bookmarked = false;
  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.data['bookmarked'] as bool;
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.2).chain(CurveTween(curve: Curves.elasticOut)).animate(_pulseCtrl);
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  Map<String, dynamic> get d => widget.data;
  bool get flagged => d['flagged'] as bool;

  void _toggleBookmark() {
    setState(() => _bookmarked = !_bookmarked);
    _pulseCtrl.forward().then((_) => _pulseCtrl.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: flagged ? const Color(0xFF181006) : ET.bgCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: flagged ? ET.goldDim.withOpacity(0.5) : ET.borderSubtle,
          width: flagged ? 1.0 : 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          if (flagged)
            BoxShadow(
              color: ET.caution.withOpacity(0.05),
              blurRadius: 24,
              offset: const Offset(0, 0),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (flagged) _FlagBanner(message: d['flagMessage'] as String),
          Padding(
            padding: const EdgeInsets.all(ET.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CardHeader(d: d, bookmarked: _bookmarked, onBookmark: _toggleBookmark, pulseAnim: _pulseAnim),
                const SizedBox(height: ET.p12),
                _CardHeadline(d: d),
                const SizedBox(height: ET.p8),
                _CardBody(d: d, expanded: _expanded, onToggle: () => setState(() => _expanded = !_expanded)),
                if (d['hasImage'] as bool) ...[
                  const SizedBox(height: ET.p12),
                  _CardImage(d: d),
                ],
                const SizedBox(height: ET.p12),
                _SourcePreview(url: d['sourceUrl'] as String, title: d['sourceTitle'] as String),
                const SizedBox(height: ET.p14),
                _CardDivider(),
                const SizedBox(height: ET.p12),
                _EvalRow(
                  counts: Map<String, int>.from(d['evalCounts'] as Map),
                  selected: _selected,
                  onSelect: (v) => setState(() => _selected = _selected == v ? null : v),
                  d: d,
                ),
                const SizedBox(height: ET.p12),
                _CredibilityBar(d: d),
                const SizedBox(height: ET.p12),
                _CardFooter(d: d),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlagBanner extends StatelessWidget {
  final String message;
  const _FlagBanner({required this.message});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: ET.p16, vertical: ET.p8),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [ET.caution.withOpacity(0.12), Colors.transparent],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(11),
        topRight: Radius.circular(11),
      ),
      border: Border(bottom: BorderSide(color: ET.caution.withOpacity(0.2), width: 0.5)),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber_rounded, size: 12, color: ET.caution),
        const SizedBox(width: ET.p6),
        Text(message.toUpperCase(), style: ET.label(8.5, color: ET.caution).copyWith(letterSpacing: 0.8)),
      ],
    ),
  );
}

class _CardHeader extends StatelessWidget {
  final Map<String, dynamic> d;
  final bool bookmarked;
  final VoidCallback onBookmark;
  final Animation<double> pulseAnim;
  const _CardHeader({required this.d, required this.bookmarked, required this.onBookmark, required this.pulseAnim});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _AvatarRing(
        initials: d['initials'] as String,
        color: d['avatarColor'] as Color,
        size: 36,
        hasRing: d['verified'] as bool,
      ),
      const SizedBox(width: ET.p10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(d['username'] as String,
                      style: ET.sans(13.5, w: FontWeight.w700, color: ET.ink),
                      overflow: TextOverflow.ellipsis),
                ),
                if (d['verified'] as bool) ...[
                  const SizedBox(width: 4),
                  Icon(Icons.verified_rounded, size: 13, color: ET.verified),
                ],
              ],
            ),
            const SizedBox(height: 2),
            Row(
              children: [
                Text(d['handle'] as String, style: ET.mono(9.5, color: ET.inkTertiary)),
                const SizedBox(width: 6),
                Text('·', style: ET.mono(9.5, color: ET.inkMuted)),
                const SizedBox(width: 6),
                Text(d['timestamp'] as String, style: ET.mono(9.5, color: ET.inkTertiary)),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(width: ET.p8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _CategoryPill(label: d['category'] as String, color: d['categoryColor'] as Color, bg: d['categoryBg'] as Color),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: onBookmark,
            child: AnimatedBuilder(
              animation: pulseAnim,
              builder: (_, child) => Transform.scale(scale: pulseAnim.value, child: child),
              child: Icon(
                bookmarked ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
                size: 17,
                color: bookmarked ? ET.gold : ET.inkTertiary,
              ),
            ),
          ),
        ],
      ),
    ],
  );
}

class _CategoryPill extends StatelessWidget {
  final String label;
  final Color color, bg;
  const _CategoryPill({required this.label, required this.color, required this.bg});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withOpacity(0.3), width: 0.5),
    ),
    child: Text(label, style: ET.label(7.5, color: color).copyWith(letterSpacing: 0.8)),
  );
}

class _CardHeadline extends StatelessWidget {
  final Map<String, dynamic> d;
  const _CardHeadline({required this.d});

  @override
  Widget build(BuildContext context) => Text(
    d['headline'] as String,
    style: ET.serif(16, w: FontWeight.w700, color: ET.ink),
  );
}

class _CardBody extends StatelessWidget {
  final Map<String, dynamic> d;
  final bool expanded;
  final VoidCallback onToggle;
  const _CardBody({required this.d, required this.expanded, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    final body = d['body'] as String;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedCrossFade(
          firstChild: Text(body, maxLines: 2, overflow: TextOverflow.ellipsis,
              style: ET.sans(13, color: ET.inkSecondary)),
          secondChild: Text(body, style: ET.sans(13, color: ET.inkSecondary)),
          crossFadeState: expanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: onToggle,
          child: Text(
            expanded ? 'Show less ↑' : 'Read full report ↓',
            style: ET.sans(11.5, w: FontWeight.w600, color: ET.gold),
          ),
        ),
      ],
    );
  }
}

class _CardImage extends StatelessWidget {
  final Map<String, dynamic> d;
  const _CardImage({required this.d});

  @override
  Widget build(BuildContext context) {
    final gradient = d['imageGradient'] as List<Color>;
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          border: Border.all(color: ET.borderSubtle, width: 0.5),
        ),
        child: Stack(
          children: [
            // Grid texture overlay
            Positioned.fill(child: CustomPaint(painter: _GridPainter())),
            // Subtle diagonal lines
            Positioned.fill(child: CustomPaint(painter: _DiagPainter())),
            // Location tag
            Positioned(
              bottom: ET.p12, left: ET.p12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.white.withOpacity(0.1), width: 0.5),
                ),
                child: Row(
                  children: [
                    Icon(Icons.location_on_outlined, size: 10, color: ET.gold),
                    const SizedBox(width: 4),
                    Text(d['imageLabel'] as String, style: ET.mono(9.5, color: ET.inkSecondary)),
                  ],
                ),
              ),
            ),
            // Image placeholder icon
            Center(
              child: Icon(Icons.image_outlined, size: 32, color: Colors.white.withOpacity(0.08)),
            ),
          ],
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.04)..strokeWidth = 0.5;
    for (double x = 0; x < size.width; x += 24) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 24) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }
  @override bool shouldRepaint(_) => false;
}

class _DiagPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white.withOpacity(0.025)..strokeWidth = 0.5;
    for (double i = -size.height; i < size.width + size.height; i += 40) {
      canvas.drawLine(Offset(i, 0), Offset(i + size.height, size.height), paint);
    }
  }
  @override bool shouldRepaint(_) => false;
}

class _SourcePreview extends StatelessWidget {
  final String url, title;
  const _SourcePreview({required this.url, required this.title});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: ET.p12, vertical: ET.p10),
    decoration: BoxDecoration(
      color: ET.bgSurface,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: ET.borderSubtle, width: 0.5),
    ),
    child: Row(
      children: [
        Container(
          width: 3, height: 28,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [ET.gold, ET.goldDim],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(2),
          ),
          margin: const EdgeInsets.only(right: ET.p10),
        ),
        Icon(Icons.link_rounded, size: 12, color: ET.inkTertiary),
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: ET.sans(12, w: FontWeight.w600, color: ET.inkSecondary)),
              Text(url, style: ET.mono(9, color: ET.inkTertiary)),
            ],
          ),
        ),
        const Icon(Icons.open_in_new_rounded, size: 13, color: ET.inkTertiary),
      ],
    ),
  );
}

class _CardDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    height: 0.5,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.transparent, ET.borderMid, Colors.transparent],
      ),
    ),
  );
}

// ─────────────────────────────────────────────
//  Evaluation Row
// ─────────────────────────────────────────────
class _EvalRow extends StatelessWidget {
  final Map<String, int> counts;
  final String? selected;
  final Function(String) onSelect;
  final Map<String, dynamic> d;

  const _EvalRow({required this.counts, required this.selected, required this.onSelect, required this.d});

  Color _colorFor(String k) {
    if (k == 'Credible') return ET.positive;
    if (k == 'Context') return ET.caution;
    return ET.dispute;
  }

  Color _surfaceFor(String k) {
    if (k == 'Credible') return ET.positiveSurface;
    if (k == 'Context') return ET.cautionSurface;
    return ET.disputeSurface;
  }

  IconData _iconFor(String k) {
    if (k == 'Credible') return Icons.check_circle_outline_rounded;
    if (k == 'Context') return Icons.info_outline_rounded;
    return Icons.cancel_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final total = counts.values.fold(0, (a, b) => a + b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('ANALYST EVALUATION', style: ET.label(8.5, color: ET.inkMuted).copyWith(letterSpacing: 1.2)),
            const Spacer(),
            Text('${total.toString()} analysts', style: ET.mono(8.5, color: ET.inkTertiary)),
          ],
        ),
        const SizedBox(height: ET.p10),
        Row(
          children: counts.entries.map((e) {
            final active = selected == e.key;
            final c = _colorFor(e.key);
            final s = _surfaceFor(e.key);
            final pct = ((e.value / total) * 100).toStringAsFixed(0);
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: e.key != counts.keys.last ? 6 : 0),
                child: GestureDetector(
                  onTap: () => onSelect(e.key),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeOut,
                    padding: const EdgeInsets.symmetric(vertical: ET.p10, horizontal: 6),
                    decoration: BoxDecoration(
                      color: active ? s : ET.bgSurface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: active ? c.withOpacity(0.6) : ET.borderSubtle,
                        width: active ? 1.0 : 0.5,
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(_iconFor(e.key), size: 15, color: active ? c : ET.inkTertiary),
                        const SizedBox(height: 4),
                        Text('$pct%', style: ET.serif(13, w: FontWeight.w800, color: active ? c : ET.inkSecondary)),
                        const SizedBox(height: 2),
                        Text(
                          e.key.toUpperCase(),
                          style: ET.label(7, color: active ? c : ET.inkMuted).copyWith(letterSpacing: 0.6),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 2),
                        Text('${e.value}', style: ET.mono(8, color: active ? c.withOpacity(0.7) : ET.inkMuted)),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: ET.p8),
        // Distribution bar
        ClipRRect(
          borderRadius: BorderRadius.circular(3),
          child: Row(
            children: counts.entries.map((e) {
              final total = counts.values.fold(0, (a, b) => a + b);
              return Expanded(
                flex: e.value,
                child: Container(
                  height: 3,
                  color: _colorFor(e.key).withOpacity(0.6),
                  margin: EdgeInsets.only(right: e.key != counts.keys.last ? 1 : 0),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
//  Credibility Bar
// ─────────────────────────────────────────────
class _CredibilityBar extends StatelessWidget {
  final Map<String, dynamic> d;
  const _CredibilityBar({required this.d});

  @override
  Widget build(BuildContext context) {
    final score = d['credibility'] as int;
    final label = d['credibilityLabel'] as String;
    final color = d['credibilityColor'] as Color;
    final surface = d['credibilitySurface'] as Color;
    final status = d['status'] as String;

    return Container(
      padding: const EdgeInsets.all(ET.p12),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.2), width: 0.5),
      ),
      child: Row(
        children: [
          // Circular indicator
          SizedBox(
            width: 44, height: 44,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: score / 100,
                  strokeWidth: 3,
                  backgroundColor: color.withOpacity(0.12),
                  valueColor: AlwaysStoppedAnimation(color),
                  strokeCap: StrokeCap.round,
                ),
                Center(child: Text('$score', style: ET.serif(12, w: FontWeight.w800, color: color))),
              ],
            ),
          ),
          const SizedBox(width: ET.p12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('CREDIBILITY INDEX', style: ET.label(8, color: color.withOpacity(0.6)).copyWith(letterSpacing: 0.8)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: color.withOpacity(0.2), width: 0.5),
                      ),
                      child: Text(label, style: ET.label(7, color: color).copyWith(letterSpacing: 0.5)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(Icons.shield_outlined, size: 10, color: color.withOpacity(0.5)),
                    const SizedBox(width: 4),
                    Text(status, style: ET.mono(9, color: color.withOpacity(0.65))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  Card Footer (social stats)
// ─────────────────────────────────────────────
class _CardFooter extends StatelessWidget {
  final Map<String, dynamic> d;
  const _CardFooter({required this.d});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(Icons.remove_red_eye_outlined, size: 13, color: ET.inkMuted),
      const SizedBox(width: 4),
      Text(d['views'] as String, style: ET.mono(9.5, color: ET.inkTertiary)),
      const SizedBox(width: ET.p16),
      Icon(Icons.share_outlined, size: 13, color: ET.inkMuted),
      const SizedBox(width: 4),
      Text(d['shares'] as String, style: ET.mono(9.5, color: ET.inkTertiary)),
      const Spacer(),
      GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            Text('FULL REPORT', style: ET.label(8.5, color: ET.gold).copyWith(letterSpacing: 0.8)),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_rounded, size: 12, color: ET.gold),
          ],
        ),
      ),
    ],
  );
}

// ─────────────────────────────────────────────
//  FAB
// ─────────────────────────────────────────────
class _Fab extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    width: 48, height: 48,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: const LinearGradient(
        colors: [ET.goldLight, ET.gold],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      boxShadow: [
        BoxShadow(color: ET.gold.withOpacity(0.3), blurRadius: 16, offset: const Offset(0, 4)),
        BoxShadow(color: ET.gold.withOpacity(0.15), blurRadius: 32, offset: const Offset(0, 8)),
      ],
    ),
    child: const Icon(Icons.edit_outlined, color: Color(0xFF0B0E14), size: 20),
  );
}
