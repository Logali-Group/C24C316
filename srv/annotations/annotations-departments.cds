using {LogaliGroup as projection} from '../service';

annotate projection.VH_Departments with {
    ID @title : 'Departments' @Common : { 
        Text : department,
        TextArrangement : #TextOnly
     }
};
