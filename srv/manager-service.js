import cds from '@sap/cds';

export default class managerService extends cds.ApplicationService {
    init (){

        this.on('getByDepartment', getByDept);

        this.on('grantAbsence', grantAbsence);
        this.on('rejectAbsence', grantAbsence);

        return super.init();
    }
}

async function getByDept (req) {
    const { Employees }  = this.entities;

    const { department } = req.data;

    return SELECT.from(Employees).where({department_code: department});
}

async function grantAbsence (req) {
    const { Absences } = this.entities;
    const { ID } = req.params[0];

    const absence = await SELECT.one.from(Absences, ID);

    if (!absence) return req.reject(404, 'Absence not found');

    if (absence.status_code !== 'PENDING') return req.reject(409, 'Absence already resolved');

    if (absence.employee_ID === req.user.id){
        return req.reject(403, 'Cannot manage your own absences');        
    }

    await UPDATE(Absences, ID).with({status_code:'APPROVED'});
    return SELECT.one.from(Absences, ID);
}

async function rejectAbsence (req) {
    const { Absences } = this.entities;
    const { ID } = req.params[0];

    const absence = await SELECT.one.from(Absences, ID);

    if (!absence) return req.reject(404, 'Absence not found');

    if (absence.status_code !== 'PENDING') return req.reject(409, 'Absence already resolved');

    if (absence.employee_ID === req.user.id){
        return req.reject(403, 'Cannot manage your own absences');        
    }

    await UPDATE(Absences, ID).with({status_code:'REJECTED'});
    return SELECT.one.from(Absences, ID);
}

