const cds = require('@sap/cds');
const moment = require('moment');

class LogaliGroup extends cds.ApplicationService {

    async init () {

        // CREATE --> NEW
        // UPDATE --> UPDATE
        // DELETE --> DELETE

        const {ProductsSet, ReviewsSet, StockSet, Suppliers, IncidentsSet} = this.entities;

        const cloud = await cds.connect.to("API_BUSINESS_PARTNER");
        const premise = await cds.connect.to('ON_PREMISE');

        this.on('READ', IncidentsSet, async (req)=>{
            return await premise.tx(req).send({
                query: req.query,
                headers: {
                    Authorization: 'Basic '+process.env.KEY
                }
            });
        }); 

        this.on('READ', Suppliers, async (req)=>{
            return await cloud.tx(req).send({
                query: req.query,                // SELECT.from(Suppliers)
                headers: {
                    apikey: process.env.APIKEY
                }
            });
        }); 

        this.before('NEW', StockSet.drafts, async (req)=>{

            let search = await SELECT.one.from(StockSet.drafts).columns(`max(stockNumber) as Max`).where({product_ID: req.data.product_ID, product_product: req.data.product_product});
            let  stockNumber = search.Max;
            console.log("StockNumber = "+stockNumber);

            if (typeof stockNumber === 'object') {
                req.data.stockNumber = 1;
            } else {
                req.data.stockNumber = stockNumber + 1;
            }
        });

        this.before('NEW', ReviewsSet.drafts, async (req)=>{
            console.log(req.data);
            req.data.creationDate = moment().format("YYYY-MM-DD");
        });

        this.before('NEW', ProductsSet.drafts, async (req)=>{
            req.data.details??= {
                baseUnit: "EA",
                width: 0.00,
                height: 0.00,
                depth: 0.00,
                weight: 0.00,
                unitVolume: "CM",
                unitWeight: "KG"
            }
        });

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