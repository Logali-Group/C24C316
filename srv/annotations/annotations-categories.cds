using {LogaliGroup as projection} from '../service';

annotate projection.VH_CategoriesSet with {
    ID @title : 'Categories' @Common : { 
        Text : category,
        TextArrangement : #TextOnly
     }
};
