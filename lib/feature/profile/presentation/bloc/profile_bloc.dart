import 'package:bloc/bloc.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_event.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_repository.dart';
import 'package:tutur_kata/feature/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc(this.repository) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
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

