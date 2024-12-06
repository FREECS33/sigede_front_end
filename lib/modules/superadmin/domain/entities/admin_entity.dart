class AdminEntity {
  final int userId;
  final String email;
  final String name;
  final String status;

  AdminEntity({required this.userId, required this.email, required this.name, required this.status});
}

class RequestAdminEntity {
  final String role;
  final int institutionId;
  RequestAdminEntity({required this.role, required this.institutionId});
}

class FilterAdminEntity {  
  final int institutionId;
  final String name;  
  final int page;
  final int size;
  FilterAdminEntity({required this.institutionId, required this.name, required this.page, required this.size});
}