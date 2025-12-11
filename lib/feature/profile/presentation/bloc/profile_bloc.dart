import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_event.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_repository.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<LogoutRequested>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      emit(ProfileLoggedOut());
    });

  }

  Future<void> _onLoadProfile(
      LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await repository.getUserProfile();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileFailure(e.toString()));
    }
  }
}

