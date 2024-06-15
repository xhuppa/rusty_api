#![feature(proc_macro_hygiene, decl_macro)]
#[macro_use]
extern crate rocket;
use std::env;
use mysql::prelude::*;
use mysql::*;
use rocket::Request;
use mysql::Opts;
mod user;

//get call
#[get("/")]
fn index() -> String {
    let url = env::var("DATABASE_URL").expect("DATABASE_URL not found in environment variables");
    let opts = Opts::from_url(&url).expect("Failed to parse the database URL");
    let pool = Pool::new(opts).expect("Failed to create connection pool");
    let mut conn = pool.get_conn().expect("Failed to get a connection from the pool");
    let v: Vec<String> = user::signin(&mut conn, "sherwanirobert@gmail.com".to_string());
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
