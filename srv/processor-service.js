import cds from '@sap/cds';

export default class processorService extends cds.ApplicationService {
    init(){

        const { Absences } = this.entities;

        this.before('CREATE', Absences , createAbsence);

        return super.init();
    }
}

async function createAbsence(req) {
    req.data.status_code = 'PENDING'; 
    req.data.employee_ID = req.user.id; 
    //req.data.employee_ID: es el ID del empleado que envía el cliente en el body del POST.
    //req.user.id: es el ID del usuario autenticado que CAP obtiene del contexto de seguridad.
    
    if (!req.data.reason_code){
        req.data.reason_code = 'TBD';
    }
}