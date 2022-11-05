import 'dart:convert';
import 'dart:developer';

import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:http/http.dart' as http;

class EditProfileRepository {
  final Network _network;

  EditProfileRepository(this._network);

  Future<dynamic> getBlocks() async {
    http.Response response;
    late GetBlocksModel myBlocks;
    try {
      response = await _network.getWithHeader('/blocks');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        myBlocks = GetBlocksModel.fromJson(data);
      }
      //log(myBlocks.userBlocks.toString());
      return myBlocks;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserBlocksItem>> getUserBlocks() async {
    http.Response response;
    late GetBlocksModel myBlocks;
    try {
      response = await _network.getWithHeader('/blocks');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        myBlocks = GetBlocksModel.fromJson(data);
      }
      //log(myBlocks.userBlocks[0].createdAt);
      return myBlocks.userBlocks;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> deleteBlocks(String id) async {
    http.Response response;
    try {
      response = await _network.deleteWithHeader('/blocks/$id');
      if (response.statusCode == 200) {
        log(response.body , name: 'delete blocks :');
      }
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> PostUserBlocks(dynamic data) async {
    http.Response response;
    var dataR;
    try {
      response = await _network.postWithHeader('/blocks', data);
      //if(response.statusCode == 200){
      dataR = json.decode(response.body);
      //myBlocks = GetBlocksModel.fromJson(data);
      //}
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> PostUserProfile({dynamic data, dynamic background , dynamic profile}) async {
    dynamic response;
    var dataR;
    try {
      log('hi');
      response =
          await _network.postPictureWithHeader('/profile/update', profile ,background, data);
      dataR = json.decode(response);
      log(dataR.toString() , name: 'post user profile :');
      return dataR;
    } catch (e) {
      log('repo:');
      log(e.toString());
      rethrow;
    }
  }

  Future<PostProfileResp> getProfileShow() async {
    http.Response response;
    late PostProfileResp myProfile;
    try {
      response = await _network.getWithHeader('/profile/show');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        myProfile = PostProfileResp.fromJson(data);
      }
      log(myProfile.user.userProfile.originalUrl);
      return myProfile;
    } catch (e) {
      rethrow;
    }
  }
}
