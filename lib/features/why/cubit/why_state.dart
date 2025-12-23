part of 'why_cubit.dart';

sealed class WhyState {
  const WhyState();
}

class WhyLoading extends WhyState {
  const WhyLoading();
}

class WhyLoaded extends WhyState {
  const WhyLoaded(this.reasons);

  final List<WhyReason> reasons;
}

class WhyFailure extends WhyState {
  const WhyFailure(this.message);

  final String message;
}
