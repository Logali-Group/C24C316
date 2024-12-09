namespace com.logaligroup;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

entity Products : cuid, managed {
    key product      : String(8);
        mediaContent : LargeBinary @UI.IsImage @Core.MediaType: mimeType @Core.ContentDisposition.Filename : fileName;
        mimeType     : String @Core.IsMediaType;
        fileName     : String;
        productName  : String;
        productName2 : String;
        description  : LargeString;
        category     : Association to Categories; //category_ID       a0648a85-a5fa-48c8-b8cc-7b1c370c2f7d --> category/category
        subCategory  : Association to SubCategories; //subCategory_ID    c96a5a1a-485d-4e5d-9a96-ce46aa3b0281 --> subCategory/description
        supplier     : Association to Suppliers; //supplier_ID and supplier_supplier
        availability : Association to Availability; //availability_code InStock --> availability/name
        criticality  : Integer;
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
    stockNumber : String(10);
    department  : String;
    min         : Decimal(5, 2);
    max         : Decimal(5, 2);
    target      : Decimal(5, 2);
    lotSize     : Decimal(6, 3);
    quantity    : Decimal(6, 3);
    unit        : String(2);
    product     : Association to Products;
};


/**
 * Entidades de ayuda
 * VH = Value Help
 */

entity Categories : cuid {
    category        : String(40);
    description     : LargeString;
    toSubCategories : Association to many SubCategories
                          on toSubCategories.category = $self;
};

entity SubCategories : cuid {
    subCategory : String(40);
    description : LargeString;
    category    : Association to Categories; //category_ID
};

entity Availability : CodeList {
    key code : String enum {
            InStock         = 'In Stock'; // 3
            NotInStock      = 'Not In Stock'; // 1
            LowAvailability = 'Low Availability'; // 2
        }
}
