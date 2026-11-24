using { cuid, managed, sap.common.CodeList } from '@sap/cds/common';

namespace sap.capire.employeemanagement;

@assert.unique : { email: [email] }
entity Employees: cuid, managed {
    firstName   : String(60) @mandatory; 
    lastName    : String(60) @mandatory; 
    email       : String(60) @mandatory; 
    hireDate    : Date;
    active      : Boolean default true;
    department  : Association to Departments;
    position    : Association to Positions;
    seniority   : Association to Seniorities;
    manager     : Association to Employees; //resolver con handler que un empleado no sea su propio jefe
    fullName    : String(123) = firstName || ' ' || lastName;  
}

entity Departments : CodeList {
    key code    : String(10);
}

entity Positions : CodeList {
    key code: String(10);
    rank    : Integer;
}

entity Seniorities : CodeList {
    key code: String(5);
}

entity Absences : cuid, managed {
    startDate   : Date;
    endDate     : Date;
    reason      : Association to Reason not null; //poner valor por default
    status      : Association to Status not null; //poner valor por default
    employee    : Association to Employees not null;
}

entity Reason : CodeList {
    key code: String(10);
}


entity Status : CodeList {
    key code: String(10);
}

//Nota: Los CSV van en db/data/ y el nombre del archivo tiene que seguir el patrón <namespace>-<Entidad>.csv.
