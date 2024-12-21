using {LogaliGroup as projection} from '../service';

annotate projection.StockSet with {
    stockNumber @title: 'Stock Bin Number' @Common.FieldControl : #ReadOnly;
    department  @title: 'Department';
    min         @title: 'Min';
    max         @title: 'Max';
    target      @title: 'Target';
    lotSize     @title: 'Lot Size'          @Measures.Unit: unit; //Esta mal escrito
    quantity    @title: 'Ordered Quantity'  @Measures.Unit: unit; //@Meausres.Unit: unit; // En Quantity no muestra nada porque los valores estan en 0
    unit        @Common.IsUnit @Common.FieldControl: #ReadOnly;
};

annotate projection.StockSet with {
    department @Common : { 
        Text : department.department,
        TextArrangement : #TextOnly,
        ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'VH_Departments',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : department_ID,
                    ValueListProperty : 'ID'
                }
            ]
        }
     }
};


annotate projection.StockSet with @(
    UI.LineItem          : [
        {
            $Type: 'UI.DataField',
            Value: stockNumber
        },
        {
            $Type: 'UI.DataField',
            Value: department_ID
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target: '@UI.Chart#ChartBullet',
        },
        {
            $Type                : 'UI.DataField',
            Value                : lotSize,
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem',
            },
        },
        {
            $Type: 'UI.DataField',
            Value: quantity
        }
    ],
    UI.DataPoint #Bullet : {
        $Type                 : 'UI.DataPointType',
        Value                 : target,
        MinimumValue          : min,
        MaximumValue          : max,
        CriticalityCalculation: {
            $Type                 : 'UI.CriticalityCalculationType',
            ImprovementDirection  : #Maximize,
            ToleranceRangeLowValue: 100,
            DeviationRangeLowValue: 20
        },
    },
    UI.Chart #ChartBullet: {
        $Type            : 'UI.ChartDefinitionType',
        ChartType        : #Bullet,
        Measures         : [target],
        MeasureAttributes: [{
            $Type    : 'UI.ChartMeasureAttributeType',
            DataPoint: '@UI.DataPoint#Bullet',
            Measure  : target
        }]
    },
    UI.FieldGroup        : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: stockNumber,
            },
            {
                $Type: 'UI.DataField',
                Value: department_ID,
            },
            {
                $Type: 'UI.DataField',
                Value: min,
            },
            {
                $Type: 'UI.DataField',
                Value: max,
            },
            {
                $Type: 'UI.DataField',
                Value: target,
            },
            {
                $Type: 'UI.DataField',
                Value: lotSize,
            },
            {
                $Type: 'UI.DataField',
                Value: quantity,
            },
        ],
    },
    UI.Facets            : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup',
        Label : 'Stock',
    }, ],
);
