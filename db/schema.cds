namespace com.logaligroup;

using {
    cuid,
    managed
} from '@sap/cds/common';

entity Products : cuid, managed {
    product      : String(8);
    productName  : String;
    description  : LargeString;
    category     : Association to VH_Categories; //category_ID       a0648a85-a5fa-48c8-b8cc-7b1c370c2f7d --> category/category
    subCategory  : Association to VH_SubCategories; //subCategory_ID    c96a5a1a-485d-4e5d-9a96-ce46aa3b0281 --> subCategory/description
    availability : String;
    rating       : Decimal(3, 2);
    price        : Decimal(6, 3);
    currency     : String(3);
    details      : Association to Details;
    toReviews    : Association to many Reviews
                       on toReviews.product = $self;
    toStock      : Association to many Stock
                       on toStock.product = $self;
};

entity Details : cuid {
    baseUnit   : String(2);
    width      : Decimal(6, 3);
    height     : Decimal(6, 3);
    depth      : Decimal(6, 3);
    weight     : Decimal(6, 3);
    unitVolume : String(2);
    unitWeight : String(2);
};

entity Suppliers : cuid {
    key supplier     : String(9);
        supplierName : String(40);
        webAddress   : String;
        contact      : Association to Contacts;
};

entity Contacts : cuid {
    fullName    : String(40);
    email       : String;
    phoneNumber : String(14);
};

entity Reviews : cuid {
    rating       : Decimal(3, 2);
    creationDate : Date;
    user         : String(20);
    reviewText   : LargeString;
    product      : Association to Products;
};

entity Stock : cuid {
    stockNumber : Int16;
    department  : String;
    min         : Decimal(5, 2);
    max         : Decimal(5, 2);
    value       : Decimal(5, 2);
    lotSize     : Decimal(6, 3);
    quantity    : Decimal(6, 3);
    unit        : String(2);
    product     : Association to Products;
};


/**
 * Entidades de ayuda
 * VH = Value Help
 */

entity VH_Categories : cuid {
    category        : String(40);
    description     : LargeString;
    toSubCategories : Association to many VH_SubCategories
                          on toSubCategories.category = $self;
};

entity VH_SubCategories : cuid {
    subCategory : String(40);
    description : LargeString;
    category    : Association to VH_Categories;
};
