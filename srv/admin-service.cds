using {sap.capire.employeemanagement as my} from '../db/schema';

@requires: 'admin'
service AdminService {
    entity Employees as projection on my.Employees actions {
        action deactivate() returns Employees;
    };
    entity Positions as projection on my.Positions;
    entity Departments as projection on my.Departments;
    entity Seniorities  as projection on my.Seniorities;
}


annotate AdminService.Employees with @odata.draft.enabled;

