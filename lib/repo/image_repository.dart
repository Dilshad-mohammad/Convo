import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';

class ImageRepository{
  Future<List<PixelFormImage>> getNetworkImages() async {

    try {
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
    } on SocketException {
        throw Exception('No Internet Connection :(');
    } on HttpException {
      throw Exception('Couldn\'t retrieve the images! Sorry!');
    } on FormatException {
      throw Exception('Bad response Format!');
    } catch (e){
      print(e);
      throw Exception('Unknown Error');
    }
  }

}