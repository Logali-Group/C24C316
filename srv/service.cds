using {com.logaligroup as entities} from '../db/schema';

service LogaliGroup {
    entity ProductsSet         as projection on entities.Products;
    entity ProductDetailsSet   as projection on entities.Details;
    entity SuppliersSet        as projection on entities.Suppliers;
    entity ContactsSet         as projection on entities.Contacts;
    entity ReviewsSet          as projection on entities.Reviews;
    entity StockSet            as projection on entities.Stock;
    entity VH_CategoriesSet    as projection on entities.VH_Categories;
    entity VH_SubCategoriesSet as projection on entities.VH_SubCategories;
};

