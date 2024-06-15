use mysql::prelude::*;
use mysql::*;

#[derive(Debug, PartialEq, Eq)]
pub struct User {
    pub user_id: i64,
    pub username: String,
    pub email: String,
    pub password: String,
    pub first_name: String,
    pub last_name: String,
    pub date_of_birth: String,
    pub user_type: i64,
}

pub fn signin(cn: &mut PooledConn, mail: String) -> Vec<String> {
    let mut result: Vec<String> = Vec::new();
    let query = format!("SELECT user_id, username, email, password, first_name, last_name, user_type FROM user WHERE email = \"{}\"", mail);

    let res = cn
        .query_map(
            query,
            |(user_id, username, email, password, first_name, last_name, user_type)| {
                User {
                    user_id,
                    username,
                    email,
                    password,
                    first_name,
                    last_name,
                    date_of_birth: String::new(),
                    user_type,
                }
            },
        )
        .expect("Query failed.");

    for r in res {
        result.push(r.password);
        result.push(r.email);
        result.push(r.user_id.to_string());
        result.push(r.first_name);
        result.push(r.user_type.to_string());
    }

    result
}

