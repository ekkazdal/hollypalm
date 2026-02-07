// ignore_for_file: type_literal_in_constant_pattern

const modelMapper = _ModelMapper();

class _ModelMapper {
  const _ModelMapper();

  T? call<T extends Object?>(final Map<String, Object?> json) {
    return _fromJson<T>(json);
  }

  static T? _fromJson<T extends Object?>(final Map<String, Object?> json) {
    switch (T) {
      // case LoginResponse:
      //   return LoginResponse.fromJson(json) as T;
    }
    return null;
  }
}
