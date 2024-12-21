using {com.logaligroup as entities} from '../db/schema';
using {API_BUSINESS_PARTNER as cloud} from './external/API_BUSINESS_PARTNER';
using {ON_PREMISE as premise} from './external/ON_PREMISE';

service LogaliGroup {
    entity ProductsSet         as projection on entities.Products;
    entity ProductDetailsSet   as projection on entities.Details;
    entity SuppliersSet        as projection on entities.Suppliers;
    entity ContactsSet         as projection on entities.Contacts;
    entity ReviewsSet          as projection on entities.Reviews;
    entity StockSet            as projection on entities.Stock;
    entity VH_CategoriesSet    as projection on entities.Categories;
    entity VH_SubCategoriesSet as projection on entities.SubCategories;
    entity VH_AvailabilitySet  as projection on entities.Availability;
    entity VH_Departments      as projection on entities.Departments;

    entity Suppliers as projection on cloud.A_Supplier {
        key Supplier as ID,
            SupplierName,
            SupplierFullName
    };

    entity IncidentsSet as projection on premise.IncidentsSet {
        IncidenceId,
        EmployeeId,
        SapId,
        CreationDate,
        Reason,
        Type
    }
};
