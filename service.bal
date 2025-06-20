
import ballerina/http;
import ballerina_crud_application.database;
import ballerina/sql;



service / on new http:Listener(9098) {
        resource function get .() returns string {
        return "Welcome to Ballerina CRUD API!";
    }

    // Resource function to get all books.
    resource function get users() returns database:User[]|http:InternalServerError {
        // Call the getBooks function to fetch data from the database.
        database:User[]|error response = database:getUsers();

        // If there's an error while fetching, return an internal server error.
        if response is error {
            return <http:InternalServerError>{
                body: "Error while retrieving books"
            };
        }

        // Return the response containing the list of books.
        return response;
    }

        resource function post users(database:UserCreate user) returns http:Created|http:InternalServerError {
        sql:ExecutionResult|sql:Error response = database:insertUser(user);
        if response is error {
            return <http:InternalServerError>{
                body: "Error while inserting book"
            };
        }
        return http:CREATED;
    }

    resource function delete users/[int id]() returns http:NoContent|http:InternalServerError {
     sql:ExecutionResult|sql:Error response = database:deleteUser(id);

     if response is error {
         return <http:InternalServerError>{
             body: "Error while deleting book"
         };
     }

     return http:NO_CONTENT;
}

resource function patch users/[int id](database:UserUpdate book) returns http:NoContent|http:InternalServerError {
    sql:ExecutionResult|sql:Error response = database:updateUser(id, book);

    if response is error {
        return <http:InternalServerError>{
            body: "Error while updating book"
        };
    }

    return http:NO_CONTENT;
    
}
}