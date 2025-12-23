import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/api/api_exception.dart';
import '../data/models/why_reason.dart';
import '../data/repositories/why_repository.dart';

part 'why_state.dart';

class WhyCubit extends Cubit<WhyState> {
  WhyCubit({required WhyRepository repository})
    : _repository = repository,
      super(const WhyLoading());

  final WhyRepository _repository;

  Future<void> loadReasons() async {
    emit(const WhyLoading());
    try {
      final reasons = await _repository.fetchReasons();
      emit(WhyLoaded(reasons));
    } catch (error) {
      _logError(error);
      emit(WhyFailure(_mapErrorToMessage(error)));
    }
  }
}

String _mapErrorToMessage(
  Object error, {
  String fallback = 'An error occurred. Please try again.',
}) {
  if (error is ApiException && error.userFriendlyMessage != null) {
    return error.userFriendlyMessage!;
  }
  return fallback;
}

void _logError(Object error) {
  if (kDebugMode) {
    // ignore: avoid_print
    print(error);
  }
}
