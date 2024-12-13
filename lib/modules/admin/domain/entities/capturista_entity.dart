class CapturistaEntity {
  final int userAccountId;
  final String name;
  final String status;
  final String email;

  const CapturistaEntity({
    required this.userAccountId,
    required this.name,
    required this.status,
    required this.email,
  });
}


class FilterCapturerEntity {
  final String name;
  final int institutionId;
  final int page;
  final int size;

  const FilterCapturerEntity({
    required this.name,
    required this.institutionId,
    required this.page,
    required this.size,
  });
}