import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/domains_state.dart';

class ManageSources extends ConsumerWidget {
  const ManageSources({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final futureDomains = ref.watch(domainsProvider);
    final controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your sources'),
      ),
      body: futureDomains.when(
        data: (domains) => CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: controller,
                  onSubmitted: (value) {
                    ref.read(domainsProvider.notifier).add(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'e.g. ign.com',
                    label: const Text('Add new'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: domains.length,
                (context, index) => ListTile(
                  title: Text(domains[index]),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 18.0,
                    ),
                    onPressed: () {
                      ref.read(domainsProvider.notifier).remove(domains[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}