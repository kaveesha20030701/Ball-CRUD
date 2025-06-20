public type User record {|
    int id;
    string name;
    string email;
    
|};


public type UserCreate record {|
    string name;
    string email;
|};

public type UserUpdate record {|
    string? name;
    string? email;
|};
