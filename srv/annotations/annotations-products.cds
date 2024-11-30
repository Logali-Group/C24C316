using {LogaliGroup as projection} from '../service';

using from './annotations-suppliers';

annotate projection.ProductsSet with {
    product      @title: 'Product';
    productName  @title: 'Product Name';
    description  @title: 'Description';
    supplier     @title: 'Supplier';
    category     @title: 'Category';
    subCategory  @title: 'Sub-Category';
    availability @title: 'Availability';
    rating       @title: 'Average Rating';
    price        @title: 'Price per Unit'  @Measures.Unit: currency;
    currency     @title: 'Currency'        @Common.IsUnit;
};

annotate projection.ProductsSet with {
    availability @Common: {
        Text : availability.name,
        TextArrangement : #TextOnly
    };
    subCategory @Common: {
        Text : subCategory.subCategory,
        TextArrangement :  #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_SubCategoriesSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterIn',
                    LocalDataProperty : category_ID,        //ProductsSet
                    ValueListProperty : 'category_ID',      //VH_SubCategoriesSet
                },
                {
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : subCategory_ID,
                    ValueListProperty : 'ID'
                }
            ]
        }
    };
    category @Common: {
        Text : category.category,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_CategoriesSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : category_ID,               //ProductsSet
                    ValueListProperty : 'ID'             //VH_CategoriesSet
                }
            ]
        }
    };
    supplier @Common: {
        Text : supplier.supplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'SuppliersSet',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,                   //ProductsSet
                    ValueListProperty : 'ID'                         //SuppliersSet
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'supplier'
                }
            ]
        }
    };
    product @Common: {
        Text : productName2
    }
};



annotate projection.ProductsSet with @(
    Capabilities.FilterRestrictions : {
        $Type : 'Capabilities.FilterRestrictionsType',
        FilterExpressionRestrictions : [
            {
                $Type : 'Capabilities.FilterExpressionRestrictionType',
                Property : supplier_ID,
                AllowedExpressions : 'SingleValue'
            }
        ]
    },
    UI.SelectionFields  : [
        supplier_ID,
        category_ID,
        subCategory_ID,
        availability_code
    ],
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Product',
        TypeNamePlural : 'Products',
        Title : {
            $Type : 'UI.DataField',
            Value : productName
        },
        Description : {
            $Type : 'UI.DataField',
            Value : product
        }
    },
    UI.LineItem: [
        {
            $Type: 'UI.DataField',
            Value: product
        },
        {
            $Type: 'UI.DataField',
            Value: productName
        },
        {
            $Type: 'UI.DataField',
            Value: supplier_ID
        },
        {
            $Type: 'UI.DataField',
            Value: category_ID
        },
        {
            $Type: 'UI.DataField',
            Value: subCategory_ID
        },
        {
            $Type: 'UI.DataField',
            Value: availability_code,
            Criticality : criticality,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            }
        },
        {
            $Type: 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint',
            Label : 'Average Rating',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            }
        },
        {
            $Type: 'UI.DataField',
            Value: price,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '8rem'
            }
        }
    ], 
    UI.DataPoint  : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization : #Rating
    },
    UI.Facets  : [
        {
            $Type : 'UI.CollectionFacet',
            Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Target : 'supplier/@UI.FieldGroup#SupplierInformation',
                            Label : 'Information'
                        },
                        {
                            $Type : 'UI.ReferenceFacet',
                            Target : 'supplier/contact/@UI.FieldGroup#ContactInformation',
                            Label : 'Contact Information'
                        }
            ],
            Label : 'Supplier Information'
        }
    ]
);
