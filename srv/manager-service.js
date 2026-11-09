import cds from '@sap/cds';

export default class managerService extends cds.ApplicationService {
    init (){

        this.on('getByDepartment', getByDept);

        return super.init();
    }
}

async function getByDept (req) {
    const { Employees }  = this.entities;

    const { department } = req.data;

    return SELECT.from(Employees).where({department_code: department});
}
