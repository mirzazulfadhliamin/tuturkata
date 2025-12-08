import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color_styles.dart';
import 'exercise_event.dart';
import 'exercise_state.dart';
import 'exercise_model.dart';

class ExerciseBloc extends Bloc<ExerciseEvent, ExerciseState> {
  ExerciseBloc() : super(ExerciseInitial()) {

    on<LoadExercisesEvent>((event, emit) async {
      emit(ExerciseLoading());

      await Future.delayed(const Duration(milliseconds: 300));

      final exercises = [
        ExerciseModel(
          id: 1,
          title: 'Membaca Kata',
          subtitle: 'Latihan pengucapan kata dasar',
          progress: 80,
          completed: false,
          iconColor: AppColor.blueLight.withOpacity(0.1).value,
          iconBg: AppColor.blueLight.value,
          gradient: [
            AppColor.blueLight.value,
            AppColor.blueDark.value,
          ],
        ),
        ExerciseModel(
          id: 2,
          title: 'Kalimat Tingkat Dasar',
          subtitle: 'Latihan pengucapan kata dasar',
          progress: 75,
          completed: false,
          iconColor: AppColor.greenLight.withOpacity(0.1).value,
          iconBg: AppColor.greenLight.value,
          gradient: [
            AppColor.greenLight.value,
            AppColor.greenDark.value,
          ],
        ),
        ExerciseModel(
          id: 3,
          title: 'Kalimat Tingkat Menengah',
          subtitle: 'Latihan pengucapan kata menengah',
          progress: 50,
          completed: false,
          iconColor: AppColor.purpleLight.withOpacity(0.1).value,
          iconBg: AppColor.purpleLight.value,
          gradient: [
            AppColor.purpleLight.value,
            AppColor.purpleDark.value,
          ],
        ),
        ExerciseModel(
          id: 4,
          title: 'Kalimat Tingkat Lanjut',
          subtitle: 'Latihan pengucapan kalimat lanjut',
          progress: 25,
          completed: false,
          iconColor: AppColor.orangeLight.withOpacity(0.1).value,
          iconBg: AppColor.orangeDark.value,
          gradient: [
            AppColor.orangeDark.value,
            AppColor.orange.value,
          ],
        ),
      ];

      emit(ExerciseLoaded(exercises: exercises));
    });
  }
}