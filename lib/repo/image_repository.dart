import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository{
  Future<List<PixelFormImage>> getNetworkImages() async {
    var endpointUrl = Uri.parse('https://picsum.photos/v2/list');
    final response = await http.get(endpointUrl);

    if (response.statusCode == 200) {
      final List<dynamic> decodedList = jsonDecode(response.body) as List;

      final List<PixelFormImage> _imageList = decodedList.map((listItem) {
        return PixelFormImage.fromJson(listItem);
      }).toList();
      return _imageList;
    } else {
      throw Exception('API not Successful');
    }
  }

}