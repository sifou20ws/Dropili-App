import 'dart:convert';
import 'dart:developer';

import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:http/http.dart' as http;

class EditProfileRepository {
  final Network _network;

  EditProfileRepository(this._network);

  Future<List<BlocksItem>> getBlocks() async {
    http.Response response;
    late GetBlocksModel myBlocks ;
    try {
      response = await _network.getWithHeader('/blocks');
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        myBlocks = GetBlocksModel.fromJson(data);
      }
      return myBlocks.blocks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List> getUserBlocks() async {
    http.Response response;
    late GetBlocksModel myBlocks ;
    try {
      response = await _network.getWithHeader('/blocks');
      if(response.statusCode == 200){
        var data = json.decode(response.body);
        myBlocks = GetBlocksModel.fromJson(data);
      }
      return myBlocks.userBlocks;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> PostUserBlocks(dynamic data) async{
    http.Response response;
    var dataR;
    try {
      response = await _network.postWithHeader('/blocks' , data );
      //if(response.statusCode == 200){
        dataR = json.decode(response.body);
        //myBlocks = GetBlocksModel.fromJson(data);
      //}
      return response.body;
    } catch (e) {
      rethrow;
    }
  }


}