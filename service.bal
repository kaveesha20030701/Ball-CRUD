
import ballerina/http;
import ballerina_crud_application.database;
import ballerina/sql;



service / on new http:Listener(9098) {
        resource function get .() returns string {
        return "Welcome to Ballerina CRUD API!";
    }

    // Resource function to get all users.
    resource function get users() returns database:User[]|http:InternalServerError {
        // Call the getBooks function to fetch data from the database.
        database:User[]|error response = database:getUsers();

        // If there's an error while fetching, return an internal server error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving users"
            };
        }

        // Return the response containing the list of users.
        return response;
    }
    resource function get users/[int id]() returns database:User|http:NotFound|http:InternalServerError {
    database:User|error response = database:getUserById(id);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while retrieving user"
        };
    }

    if response is database:User {
        return response;
    }
}

resource function get users/search/[string q]() returns database:User[]|http:InternalServerError {
    database:User[]|error response = database:searchUsers(q);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while searching users"
        };
    }

    return response;
}




        resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting user"
            };
        }
        return http:CREATED;
    }

    resource function delete users/[int id]() returns http:NoContent|http:InternalServerError {
     sql:ExecutionResult|sql:Error response = database:deleteUser(id);

     if response is error {
         return <http:InternalServerError>{
             body: "Error while deleting user"
         };
     }

     return http:NO_CONTENT;
}

resource function patch users/[int id](database:UserUpdate user) returns http:NoContent|http:InternalServerError {
    sql:ExecutionResult|sql:Error response = database:updateUser(id, user);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while updating user"
        };
    }

    return http:NO_CONTENT;
    
}
}