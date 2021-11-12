import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_gallery_flutter/controllers/gallery_controller.dart';

class PhotoGalleryScreen extends StatelessWidget {
  PhotoGalleryScreen({Key? key}) : super(key: key);

  final GalleryController galleryController = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GetBuilder<GalleryController>(
            builder: (controller) {

              if (controller.status == GalleryStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.status == GalleryStatus.loaded) {

                return GridView.builder(
                  itemCount: controller.images.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0),
                  itemBuilder: (context, index) {
                    return Image.network(controller.images[index],
                        fit: BoxFit.cover);
                  },
                );
              }
              return Container();

            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          galleryController.loadMore();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
