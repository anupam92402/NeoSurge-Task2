import 'package:flutter/material.dart';
import 'package:neosurge_task2/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MoviesProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Home',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(
                    color: Colors.grey, // Color of the border
                    width: 2, // Width of the border
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: 'Search for movies',
                            border: InputBorder.none),
                        onChanged: (value) {
                          provider.userInput = value;
                        },
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          provider.isLoading = true;
                          provider.getMoviesList();
                        },
                        child: const Icon(Icons.search))
                  ],
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (provider.list.isEmpty) {
                      return const Center(
                        child: Text("Please Search Your Favorite Movie"),
                      );
                    } else {
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 12,
                        child: Container(
                            height: 200,
                            color: Colors.white,
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(provider.list.isEmpty
                                      ? 'https://images.unsplash.com/photo-1490730141103-6cac27aaab94?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2070&q=80'
                                      : provider.list[index].poster),
                                ),
                                const SizedBox(
                                  width: 18,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 180,
                                      child: Text(
                                        provider.list[index].title,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      provider.list[index].genre,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: (double.parse(provider
                                                    .list[index].imdbRating) >=
                                                7.5)
                                            ? Colors.green
                                            : Colors.blue,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${provider.list[index].imdbRating} IMDB',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      );
                    }
                  },
                  scrollDirection: Axis.vertical,
                  itemCount: provider.list.isEmpty ? 1 : provider.list.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}