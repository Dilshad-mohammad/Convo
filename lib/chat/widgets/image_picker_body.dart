import 'package:flutter/material.dart';

import '../../models/image_model.dart';
import '../../repo/image_repository.dart';

class NetworkImagePickerBody extends StatelessWidget {
  final Function(String) onImageSelected;
  NetworkImagePickerBody({super.key, required this.onImageSelected,});

  final ImageRepository _imageRepository = ImageRepository();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      child: FutureBuilder<List<PixelFormImage>>(
          future: _imageRepository.getNetworkImages(),
          builder: (BuildContext context, AsyncSnapshot<List<PixelFormImage>> snapshot){
            if (snapshot.hasData) {
              return GridView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index){
                    return GestureDetector(
                      onTap: (){
                        onImageSelected(snapshot.data![index].downloadUrl);
                      },
                        child: Image.network(snapshot.data![index].downloadUrl));
                  },
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 0,
                    maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5),
              );
            } else if (snapshot.hasError){
              return Padding(padding: EdgeInsets.all(24),
              child: Text('Error: ${snapshot.error}'),
              );
            }
      
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}
