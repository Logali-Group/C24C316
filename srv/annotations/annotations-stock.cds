using {LogaliGroup as projection} from '../service';

annotate projection.StockSet with {
    stockNumber @title: 'Stock Bin Number';
    department  @title: 'Department';
    target      @title: 'Target';
    lotSize     @title: 'Lot Size'          @Measures.Unit: unit;   //Esta mal escrito
    quantity    @title: 'Ordered Quantity'  @Measures.Unit: unit;   //@Meausres.Unit: unit; // En Quantity no muestra nada porque los valores estan en 0
    unit        @Common.IsUnit;
};

annotate projection.StockSet with @(
    UI.LineItem  : [
        {
            $Type : 'UI.DataField',
            Value : stockNumber
        },
        {
            $Type : 'UI.DataField',
            Value : department
        },
        {
            $Type : 'UI.DataFieldForAnnotation',
            Target : '@UI.Chart#ChartBullet',
        },
        {
            $Type : 'UI.DataField',
            Value : lotSize,
            ![@HTML5.CssDefaults] : {
                $Type : 'HTML5.CssDefaultsType',
                width : '10rem',
            },
        },
        {
            $Type : 'UI.DataField',
            Value : quantity
        }
    ],
    UI.DataPoint #Bullet : {
        $Type : 'UI.DataPointType',
        Value : target,
        MinimumValue : min,
        MaximumValue : max,
        CriticalityCalculation : {
            $Type : 'UI.CriticalityCalculationType',
            ImprovementDirection : #Maximize,
            ToleranceRangeLowValue : 100,
            DeviationRangeLowValue : 20
        },
    },
    UI.Chart #ChartBullet : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bullet,
        Measures : [
            target
        ],
        MeasureAttributes : [
            {
                $Type : 'UI.ChartMeasureAttributeType',
                DataPoint : '@UI.DataPoint#Bullet',
                Measure : target
            }
        ]
    }
);

