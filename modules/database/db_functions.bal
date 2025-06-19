import ballerina/sql;

// Define the function to fetch books from the database.
public isolated function getUsers() returns User[]|sql:Error {
    // Execute the query and return a stream of Book records.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersQuery());
    
    // Check if the result is a stream of Book records.
    if resultStream is stream<User> {
        return from User User in resultStream
            select User;
    }
    
    // If there is an error, return an error message.
    return error("Error fetching books");
}

public isolated function insertUser(UserCreate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(insertUserQuery(payload));
}

public isolated function deleteUser(int userId) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(deleteUserQuery(userId));
}

public isolated function updateUser(int userId, UserUpdate payload) returns sql:ExecutionResult|sql:Error {
    return dbClient->execute(updateUserQuery(userId, payload));
}