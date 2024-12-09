const cds = require('@sap/cds');

class LogaliGroup extends cds.ApplicationService {

    init () {

        // CREATE --> NEW
        // UPDATE --> UPDATE
        // DELETE --> DELETE

        const {ProductsSet} = this.entities;

        this.after('UPDATE', ProductsSet.drafts, async (req) =>{
            if (req.availability_code) {
                let code = req.availability_code;
                if (code === 'InStock') {
                    await this.updateCriticality(req, ProductsSet, 3);
                } else if (code === 'LowAvailability') {
                    await this.updateCriticality(req, ProductsSet, 2);
                } else if (code === 'NotInStock') {
                    await this.updateCriticality(req, ProductsSet, 1);
                }
            }
        });


        return super.init();
    }

    async updateCriticality (req, entity, criticality) {
        return await UPDATE.entity(entity.drafts).set({criticality: criticality}).where({ID: req.ID, product: req.product});
    }
}

module.exports = LogaliGroup;