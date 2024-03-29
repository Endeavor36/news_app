import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/domains_provider.dart';

class ManageSourcesScreen extends ConsumerWidget {
  const ManageSourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncDomains = ref.watch(domainsProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your sources'),
        bottom: asyncDomains.isLoading
            ? const PreferredSize(
                preferredSize: Size.fromHeight(4.0),
                child: LinearProgressIndicator())
            : null,
      ),
      body: asyncDomains.when(
          data: (domains) => SafeArea(
                child: CustomScrollView(
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
                    domains.isEmpty
                        ? const SliverToBoxAdapter(
                            child: Center(
                              child: Text('No sources found'),
                            ),
                          )
                        : SliverList(
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
                                    ref
                                        .read(domainsProvider.notifier)
                                        .remove(domains[index]);
                                  },
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              ),
          error: (error, stackTrace) =>
              const Center(child: Text('Error loading domains')),
          loading: () => const SizedBox()),
    );
  }
}
