/// The status that indicates the current state while executing the task has
/// the time to response.
enum DataLoadStatus {
  /// The initial status.
  initial,

  /// The status that indicates waiting for the response.
  loading,

  /// The status that indicates the success response.
  success,

  /// The status that indicates the failure response.
  failure,
}
