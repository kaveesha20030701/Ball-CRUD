import ballerina/sql;

isolated function getUsersQuery() returns sql:ParameterizedQuery => `
    SELECT 
        id,
        name,
        email
    FROM 
        user;
`;

isolated function insertUserQuery(UserCreate payload) returns sql:ParameterizedQuery => `
    INSERT INTO user
        (
            name,
            email
        )
    VALUES
        (
            ${payload.name},
            ${payload.email}
        )
`;

isolated function deleteUserQuery(int userId) returns sql:ParameterizedQuery => `
    DELETE FROM user WHERE id = ${userId}
`;

isolated function updateUserQuery(int userId, UserUpdate payload) returns sql:ParameterizedQuery =>`
    UPDATE user
        SET 
            name = COALESCE(${payload.name}, name),
            email = COALESCE(${payload.email}, email)
        WHERE id = ${userId}
`;