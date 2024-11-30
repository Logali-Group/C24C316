using {LogaliGroup as projection} from '../service';

annotate projection.ContactsSet with {
    fullName    @title: 'Full Name';
    phoneNumber @title: 'Phone Number';
    email       @title: 'Email';
};


annotate projection.ContactsSet with @(
    UI.FieldGroup #ContactInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : fullName
            },
            {
                $Type : 'UI.DataField',
                Value : email
            },
            {
                $Type : 'UI.DataField',
                Value : phoneNumber
            }
        ]
    }
);
