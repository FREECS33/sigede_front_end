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

class AddAdminEntity {
  final String email;
  final String name;  
  final int fkInstitution;
  AddAdminEntity({required this.email, required this.name,required this.fkInstitution, });
}

class ResponseAddAdminEntity {
  final int status;  
  ResponseAddAdminEntity({required this.status});
}

class UpdateAdminEntity {  
  final String email;  
  final String status;
  UpdateAdminEntity({required this.email, required this.status});
}

class UpdateInfoAdminEntity {
  final int userId;  
  final String name;
  final String status;
  UpdateInfoAdminEntity({required this.userId, required this.name, required this.status});
}