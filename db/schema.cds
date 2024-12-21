namespace com.logaligroup;

using {
    cuid,
    managed,
    sap.common.CodeList
} from '@sap/cds/common';

using {API_BUSINESS_PARTNER as cloud} from '../srv/external/API_BUSINESS_PARTNER';

entity Products : cuid, managed {
    key product      : String(8) default 'HT-0001';
        mediaContent : LargeBinary  @UI.IsImage  @Core.MediaType: mimeType  @Core.ContentDisposition.Filename: fileName;
        mimeType     : String       @Core.IsMediaType;
        fileName     : String;
        productName  : String;
        productName2 : String;
        description  : LargeString;
        category     : Association to Categories; //category_ID       a0648a85-a5fa-48c8-b8cc-7b1c370c2f7d --> category/category
        subCategory  : Association to SubCategories; //subCategory_ID    c96a5a1a-485d-4e5d-9a96-ce46aa3b0281 --> subCategory/description
        supplier     : Association to Suppliers; //supplier_ID and supplier_supplier
        supplier2    : Association to cloud.A_Supplier;
        availability : Association to Availability; //availability_code InStock --> availability/name
        criticality  : Integer;
        rating       : Decimal(3, 2);
        price        : Decimal(6, 3);
        currency     : String(3) default 'USD';
        details      : Composition of Details;
        toReviews    : Composition of many Reviews
                           on toReviews.product = $self;
        toStock      : Composition of many Stock
                           on toStock.product = $self;
};

entity Details : cuid {
    baseUnit   : String(2) default 'EA';
    width      : Decimal(6, 3);
    height     : Decimal(6, 3);
    depth      : Decimal(6, 3);
    weight     : Decimal(6, 3);
    unitVolume : String(2) default 'CM';
    unitWeight : String(2) default 'KG';
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
    user         : String(20) @cds.on.insert: $user;
    reviewText   : LargeString;
    product      : Association to Products;
};

entity Stock : cuid {
    stockNumber : Integer;
    department  : Association to Departments; //department_ID
    min         : Decimal(5, 2);
    max         : Decimal(5, 2);
    target      : Decimal(5, 2);
    lotSize     : Decimal(6, 3);
    quantity    : Decimal(6, 3);
    unit        : String(2) default 'EA';
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

entity Departments : cuid {
    department : String(40);
}
