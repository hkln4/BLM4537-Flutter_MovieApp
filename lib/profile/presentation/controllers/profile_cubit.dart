import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/profile_model.dart';

class ProfileCubit extends Cubit<ProfileModel?> {
  ProfileCubit() : super(null) {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = prefs.getString('profile');
    if (profileString != null) {
      final profileMap = jsonDecode(profileString);
      emit(ProfileModel.fromJson(profileMap));
    }
  }

  Future<void> saveProfile(ProfileModel profile) async {
    final prefs = await SharedPreferences.getInstance();
    final profileString = jsonEncode(profile.toJson());
    await prefs.setString('profile', profileString);
    emit(profile);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('profile');
    emit(null);
  }

  int? get currentUserId {
    final profile = state;
    return profile?.userId;
  }

  bool get isLoggedIn {
    return state != null;
  }
}
