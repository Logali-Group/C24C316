using {LogaliGroup as projection} from '../service';
using from './annotations-contacts';

//{} --> Las anotaciones son para los campos de las entidades
//@() --> Las anotaciones son directamente para la entidad

annotate projection.SuppliersSet with {
    ID @title : 'Suppliers' @Common: {
        Text : supplierName,
        TextArrangement : #TextOnly
    };
    supplier @title : 'Supplier';
    supplierName @title : 'Supplier Name';
    webAddress @title : 'Web Address'
};

annotate projection.SuppliersSet with @(
    UI.FieldGroup #SupplierInformation: {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : supplier
            },   
            {
                $Type : 'UI.DataField',
                Value : supplierName
            },
            {
                $Type : 'UI.DataField',
                Value : webAddress
            }
        ],
        Label : 'Information'
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup#SupplierInformation',
            Label : 'Supplier Information',
        }
    ],
);

