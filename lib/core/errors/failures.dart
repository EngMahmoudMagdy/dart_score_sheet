import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List<Object> properties;

  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  Failure({this.properties = const []});

  @override
  List<Object> get props => properties;

  @override
  bool? get stringify => super.stringify;
}

class CacheFailure extends Failure {
  CacheFailure({List<Object> properties = const []})
      : super(properties: properties);
}
