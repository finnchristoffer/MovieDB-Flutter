import 'package:flutter/material.dart';
import 'package:flutter_movie_db/movie/providers/movie_get_discover_providers.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().fetchMovie(context);
    });
    return Scaffold(
      appBar: AppBar(title: const Text('Movie DB')),
      body: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movies.isNotEmpty) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final movie = provider.movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 4),
              itemCount: provider.movies.length,
            );
          }

          return const Center(
            child: Text('Not found discover movie'),
          );
        },
      ),
    );
  }
}
