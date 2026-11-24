using {sap.capire.employeemanagement as my } from '../db/schema';

@requires: ['manager']
service managerService {
    @restrict: [
        {grant: 'READ', to: 'manager', where: 'department_code = $user.Department'} //department (a la izquierda del =) es la columna de la entidad Employees, o sea el dato de cada fila. $user.Department es el atributo del usuario logueado, que viene en su token JWT (el que se cargó en la role collection). 
    ]

    entity Employees as projection on my.Employees excluding 
    { createdAt, createdBy, firstName, lastName };

    entity Departments as projection on my.Departments;

    entity Positions as projection on my.Positions;

    @restrict: [
        {grant: 'READ', to: 'manager', where: 'employee.department_code = $user.Department'},
        {grant: ['grantAbsence', 'rejectAbsence'], to: 'manager', where: 'employee.department_code = $user.Department'}
    ]

    entity Absences as projection on my.Absences actions {
        action grantAbsence() returns Absences;
        action rejectAbsence() returns Absences;
    };

    function getByDepartment (department : String) returns array of Employees;
} 



