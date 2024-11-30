using {LogaliGroup as projection} from '../service';

annotate projection.VH_SubCategoriesSet with {
    ID @title : 'SubCategories' @Common : { 
        Text : subCategory,
        TextArrangement : #TextOnly
     }
};
