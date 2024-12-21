using {LogaliGroup as projection} from '../service';

annotate projection.ReviewsSet with {
    creationDate @title: 'Creation Date' @Common: {
        Text : user
    } @Common.FieldControl: #ReadOnly;
    user         @title: 'User' @Common.FieldControl: #ReadOnly;
    rating       @title: 'Rating';
    reviewText   @title: 'Review Text' @UI.MultiLineText;
};


annotate projection.ReviewsSet with @(
    UI.HeaderInfo  : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Review',
        TypeNamePlural : 'Reviews',
        Title : {
            $Type : 'UI.DataField',
            Value : product.productName,
        },
        Description : {
            $Type : 'UI.DataField',
            Value : product.product
        }
    },
    UI.LineItem  : [
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.DataPoint#RatingIndicator',
            Label : 'Rating',
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem'
            }
        },
        {
            $Type : 'UI.DataField',
            Value : creationDate
        },
        {
            $Type : 'UI.DataField',
            Value : reviewText
        }
    ],
    UI.DataPoint #RatingIndicator : {
        $Type : 'UI.DataPointType',
        Value : rating,
        Visualization : #Rating
    },
    UI.FieldGroup  : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : creationDate
            },
            {
                $Type : 'UI.DataField',
                Value : user
            },
            {
                $Type : 'UI.DataField',
                Value : rating
            },
            {
                $Type : 'UI.DataField',
                Value : reviewText
            }
        ]
    },
    UI.Facets  : [
        {
            $Type : 'UI.ReferenceFacet',
            Target : '@UI.FieldGroup',
            Label : 'Review'
        },
    ],
);
