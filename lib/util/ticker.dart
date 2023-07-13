/// Count up every 1 second.
///
/// Creates a [Stream] that emits an [int] incremented by one every 1 second.
///
Stream<int> countUp() {
  return Stream.periodic(
    const Duration(milliseconds: 1000),
    (int ticks) => ticks + 1,
  );
}

/// Countdown every 1 second starting from [duration].
///
/// Creates a [Stream] that emits an [int] decremented by one from [duration]
/// every 1 second.
///
Stream<int> countdown(Duration duration) {
  return Stream.periodic(
    const Duration(milliseconds: 1000),
    (int ticks) => duration.inSeconds - (ticks + 1),
  );
}
