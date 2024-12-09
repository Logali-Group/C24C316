using {LogaliGroup as projection} from '../service';

annotate projection.ProductDetailsSet with {
    baseUnit @title: 'Base Unit';
    width    @title: 'Width' @Measures.Unit: unitVolume;
    height   @title: 'Height' @Measures.Unit: unitVolume;
    depth    @title: 'Depth' @Measures.Unit: unitVolume;
    weight   @title: 'Wight' @Measures.Unit: unitWeight;
    unitVolume @Common.IsUnit;
    unitWeight @Common.IsUnit;
};

annotate projection.ProductDetailsSet with @(
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : baseUnit
            },
            {
                $Type : 'UI.DataField',
                Value : width
            },
            {
                $Type : 'UI.DataField',
                Value : height
            },
            {
                $Type : 'UI.DataField',
                Value : depth
            },
            {
                $Type : 'UI.DataField',
                Value : weight
            }
        ]
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
            Label : 'Product Details'
        }
    ],
);

