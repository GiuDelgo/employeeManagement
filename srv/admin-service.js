import cds from '@sap/cds';

const EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

export default class AdminService extends cds.ApplicationService {
    init() {        
        const { Employees } = this.entities;

        this.on('deactivate', Employees, deactivate);
        this.before('CREATE', Employees, validateEmployee);

        return super.init();
    }
}

async function deactivate(req) {
    const { Employees } = this.entities;

    const [{ID}] = req.params;

    const affected = await UPDATE.entity(Employees, ID).with({active: false});

    if (!affected) return req.reject(404, `Employee #${ID} doesn't exist`);

    return SELECT.one.from(Employees, ID);
}

function validateEmployee (req) {
    const { email, hireDate } = req.data;

    if (!EMAIL_REGEX.test(email)) req.error(400, 'Enter a valid email');  
    if (!hireDate || new Date(hireDate) > new Date()) req.error(400, 'Hire date is mandatory and must be in the past');
}