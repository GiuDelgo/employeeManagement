using { sap.capire.employeemanagement as my } from '../db/schema';

service processorService{
    entity Absences as projection on my.Absences {
        *, status @readonly, createdAt @readonly, createdBy @readonly, employee.ID as employeeID @readonly
    };
}



