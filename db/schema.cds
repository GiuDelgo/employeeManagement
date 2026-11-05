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
    manager     : Association to Employees;
    fullName = firstName || ' ' || lastName;
}

entity Departments : CodeList {
    key code    : String(10);
    head        : Association to Employees;
}

entity Positions : CodeList {
    key code: String(10);
    rank    : Integer;
}

entity Seniorities : CodeList {
    key code: String(5) enum {
    }
}


/*
    {
        directory = 'D';
        financial = 'F';
        marketing = 'M';
        sales = 'S';
        technologies = 'T';
        legal = 'L';
        humanResources ='HR';
    }

    {
        ceo = 'CEO';
        cfo = 'CFO';
        cto = 'CTO';
        coo = 'COO';
        director = 'Dir';
        manager = 'Mgr';
        supervisor = 'Sup';
        specialist = 'Spec';
        analist = 'An';
    }

    {

    }
*/