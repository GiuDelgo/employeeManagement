using {sap.capire.employeemanagement as my } from '../db/schema';

@requires: 'processor'
service processorService {
    @readonly entity Employees as projection on my.Employees excluding 
    { createdAt, createdBy, firstName, lastName };

    entity Departments as projection on my.Departments;

    entity Positions as projection on my.Positions;

    function getByDepartment (department : String) returns array of Employees;
}