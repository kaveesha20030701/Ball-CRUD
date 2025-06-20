import ballerina/sql;

// Define the function to fetch users from the database.
public isolated function getUsers() returns User[]|sql:Error {
    // Execute the query and return a stream of User records.
    stream<User, sql:Error?> resultStream = dbClient->query(getUsersQuery());
    
    // Check if the result is a stream of User records.
    if resultStream is stream<User> {
        return from User User in resultStream
            select User;
    }
    
    // If there is an error, return an error message.
    return error("Error fetching users");
}
public isolated function getUserById(int id) returns User|error {
    stream<User, sql:Error?> resultStream = dbClient->query(`SELECT id, name, email FROM user WHERE id = ${id}`);

    if resultStream is stream<User> {
        var result = resultStream.next();
        if result is record {| User value; |} {
            return result.value;
        } else {
            return error("User not found");
        }
    }

    return error("Error fetching user");
}
public isolated function searchUsers(string term) returns User[]|sql:Error {
    string likeTerm = "%" + term + "%";
    stream<User, sql:Error?> resultStream = dbClient->query(`SELECT id, name, email FROM user WHERE name LIKE ${likeTerm} OR email LIKE ${likeTerm}`);

    if resultStream is stream<User> {
        return from User user in resultStream
            select user;
    }

    return error("Error searching users");
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