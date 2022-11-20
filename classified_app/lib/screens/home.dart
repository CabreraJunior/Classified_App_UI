import 'package:classified_app/custom_widgets/custom1.dart';
import 'package:classified_app/data/ads_data.dart';
import 'package:classified_app/navigation/const_routes.dart';
import 'package:classified_app/services/ads_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  //final dynamic _data = ads;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ads Listing"),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, settingsPage);
              },
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/avatar.jpg"),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: AdService().fetchAds(context),
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              var fetchedAds = snapshot.data!;
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.7),
                itemCount: fetchedAds["data"].length,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, productDetailPage,
                          arguments: fetchedAds["data"][index]);
                    },
                    child: Custom1(
                      name: fetchedAds["data"][index]["title"],
                      price: fetchedAds["data"][index]["price"],
                      description: fetchedAds["data"][index]["description"],
                      image: fetchedAds["data"][index]["images"],
                    ),
                  );
                }),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, createAdPage);
        },
        backgroundColor: const Color(0xfff25723),
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
