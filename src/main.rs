#![feature(proc_macro_hygiene, decl_macro)]
#[macro_use]
extern crate rocket;
use std::env;
use mysql::prelude::*;
use mysql::*;
use rocket::Request;
use mysql::Opts;

#[derive(Debug, PartialEq, Eq)]
struct User {
    user_id: i64,
    username: String,
    email: String,
    password: String,
    first_name: String,
    last_name: String,
    date_of_birth: String,
    user_type: i64,
}

// Sign-in function for users
fn signin(cn: &mut PooledConn, mail: String) -> Vec<String> {
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
                    date_of_birth: String::new(), // Replace this with the appropriate value
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

//get call
#[get("/")]
fn index() -> String {
    let url = env::var("DATABASE_URL").expect("DATABASE_URL not found in environment variables");
    let opts = Opts::from_url(&url).expect("Failed to parse the database URL");
    let pool = Pool::new(opts).expect("Failed to create connection pool");
    let mut conn = pool.get_conn().expect("Failed to get a connection from the pool");
    let v: Vec<String> = signin(&mut conn, "sherwanirobert@gmail.com".to_string());
    let pass: String = v[0].clone();
    let fname: String = v[3].clone();
    let uid: String = v[4].clone();
    format!("first name: {} uid:{} password: {}", fname, uid, pass)
}
//route for 404 rsponse
#[catch(404)]
fn not_found(req: &Request) -> String {
    format!("Oh no! We couldn't find the requested path '{}'", req.uri())
}

//Main function
fn main() {
    rocket::ignite()
        .register(catchers![not_found])
        .mount("/", routes![index])
        .launch();
}
