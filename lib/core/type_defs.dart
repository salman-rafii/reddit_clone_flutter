import 'package:fpdart/fpdart.dart';
import 'package:reddit_clone_flutter/core/failure.dart';

// defined your own types to catch the exceptions
typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
