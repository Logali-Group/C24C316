using {LogaliGroup as projection} from '../service';

using from './annotations-suppliers';
using from './annotations-details';
using from './annotations-reviews';
using from './annotations-stock';

annotate projection.ProductsSet with @odata.draft.enabled;

annotate projection.ProductsSet with {
    product      @title: 'Product';
    productName  @title: 'Product Name';
    description  @title: 'Description' @UI.MultiLineText;
    supplier     @title: 'Supplier';
    supplier2 @title : 'Supplier';
    category     @title: 'Category';
    subCategory  @title: 'Sub-Category';
    availability @title: 'Availability';
    rating       @title: 'Average Rating';
    price        @title: 'Price per Unit'  @Measures.Unit: currency;
    currency     @title: 'Currency'        @Common.IsUnit @Common.FieldControl : #ReadOnly;
    mediaContent @title : 'Image';
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
                    $Type : 'Common.ValueListParameterOut',
                    LocalDataProperty : supplier_supplier,
                    ValueListProperty : 'supplier',
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
    };
    supplier2 @Common: {
        Text : supplier2.SupplierName,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier2_Supplier,
                    ValueListProperty : 'ID'
                }
            ]
        }
    }
};



annotate projection.ProductsSet with @(
    Common.SideEffects  : {
        $Type : 'Common.SideEffectsType',
        SourceProperties : [
            supplier_ID
        ],
        TargetEntities : [
            'supplier',
            'supplier/contact'
        ],
    },
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
            $Type : 'UI.DataField',
            Value : mediaContent,
        },
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
    UI.FieldGroup #Submit : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : mediaContent,
                Label : ''
            }
        ]
    },
    UI.FieldGroup #GroupA : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : category_ID
            },
            {
                $Type : 'UI.DataField',
                Value : subCategory_ID
            },
            {
                $Type : 'UI.DataField',
                Value : supplier_ID
            },
            {
                $Type : 'UI.DataField',
                Value : supplier2_Supplier
            },
        ],
    },
    UI.FieldGroup #GroupB : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : description,
                Label : ''
            }
        ]
    },
    UI.FieldGroup #GroupC : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : availability_code,
                Criticality : criticality,
                Label : ''
            }
        ]
    },
    UI.FieldGroup #GroudD : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : price,
                Label : ''
            }
        ]
    },
    UI.HeaderFacets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#Submit',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupA'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupB',
            Label : 'Product Description'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroupC',
            Label : 'Availability'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#GroudD',
            Label : 'Price'
        },
    ],
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
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'details/@UI.FieldGroup',
            Label : 'Product Information'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toReviews/@UI.LineItem',
            Label : 'Reviews'
        },
        {
            $Type : 'UI.ReferenceFacet',
            Target : 'toStock/@UI.LineItem',
            Label : 'Inventory Information'
        },
    ]
);
