using {sap.capire.employeemanagement as my } from '../db/schema';

@requires: ['HRadmin', 'manager']
service managerService {
    @restrict: [
        {grant: 'READ', to: 'manager', where: 'deparment = $user.Deparment'} //department (a la izquierda del =) es la columna de la entidad Employees, o sea el dato de cada fila. $user.Department es el atributo del usuario logueado, que viene en su token JWT (el que se cargó en la role collection).
    ]

    @readonly entity Employees as projection on my.Employees excluding 
    { createdAt, createdBy, firstName, lastName };

    entity Departments as projection on my.Departments;

    entity Positions as projection on my.Positions;

    function getByDepartment (department : String) returns array of Employees;
}