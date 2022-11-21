import 'dart:convert';
import 'dart:developer';

import 'package:dropili/core/api/post_get.dart';
import 'package:dropili/core/error/failure.dart';
import 'package:dropili/data/models/delete_block_response_model.dart';
import 'package:dropili/data/models/get_blocks_model.dart';
import 'package:dropili/data/models/get_friends_result_model.dart.dart';
import 'package:dropili/data/models/post_user_profile_response.dart';
import 'package:http/http.dart' as http;

class ProfileRepository {
  final Network _network;

  ProfileRepository(this._network);

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

  Future<DeleteBlockResponse> deleteBlocks(String id) async {
    http.Response response;
    late DeleteBlockResponse deleteResponse;
    try {
      response = await _network.deleteWithHeader('/blocks/$id');
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        deleteResponse = DeleteBlockResponse.fromJson(data);
        //log(response.body , name: 'delete blocks :');
      }
      return deleteResponse;
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

  Future<dynamic> PutUserBlocks(dynamic data , int id) async {
    http.Response response;
    var dataR;
    try {
      response = await _network.putWithHeader('/blocks/$id', data);
      //if(response.statusCode == 200){
      dataR = json.decode(response.body);
      //myBlocks = GetBlocksModel.fromJson(data);
      //}
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> PostUserProfile(
      {dynamic data, dynamic background, dynamic profile}) async {
    dynamic response;
    var dataR;
    try {
      response = await _network.postPictureWithHeader(
          '/profile/update', profile, background, data);
      dataR = json.decode(response);
      return dataR;
    } catch (e) {
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
      return myProfile;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<FriendsItem>> getFriends() async {
    http.Response response;
    late GetFriendsModel friends;
    try {
      response = await _network.getWithHeader('/friends');
      var data = json.decode(response.body);
      friends = GetFriendsModel.fromJson(data);
      return friends.friends;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addFriend(int id) async {
    http.Response response;
    var data = {'id': id};

    try {
      response = await _network.postWithHeader('/friends', data);

      if (response.statusCode == 500) {
        throw Failure(message: 'Could not add friend');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteFriend(String id) async {
    http.Response response;
    try {
      response = await _network.deleteWithHeader('/friends/' + id);
      var data = json.decode(response.body);
      return data['success'];
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> directOnMe({dynamic data}) async {
    dynamic response;
    var dataR;
    try {
      response = await _network.patchWithHeader('/direct', data);
      dataR = json.decode(response.body);
      log(dataR.toString());
      return dataR;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> PostCostumeBlock({dynamic data, dynamic icon}) async {
    dynamic response;
    var dataR;
    try {
      response = await _network.postOnePictureWithHeader(
          '/custom-blocks', icon, data);
      dataR = json.decode(response);
      return dataR;
    } catch (e) {
      rethrow;
    }
  }


  Future<int> getIdFromUsername(String username) async {
    http.Response response;

    try {
      response = await _network.getWithHeader('/get-id/' + username);

      var data = json.decode(response.body);

      if (data['user'] == null) {
        throw Failure(message: 'No user registred with this name');
      }

      return data['user']['id'];
    } catch (e) {
      rethrow;
    }
  }
}
