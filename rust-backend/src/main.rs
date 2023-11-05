#[macro_use] extern crate rocket;

use rocket::http::ContentType;
use rocket::response::{content::RawHtml, Response};
use rocket::State;
use std::{io, fs::{self, File}};

struct CssFilePath(String);

#[get("/")]
fn index() -> RawHtml<&'static str> {
    RawHtml(r#"
<link rel="stylesheet" href="output.css">
<script src="https://unpkg.com/htmx.org@1.9.7"></script>
<button class="p-6" hx-post="/clicked" hx-swap="outerHTML">
    Click Me
</button>
    "#)
}

#[post("/clicked")]
fn clicked() -> RawHtml<&'static str> {
    RawHtml(r#"
<div>I have been clicked on</div>
    "#)
}

#[get("/output.css")]
fn css(file_path: &State<CssFilePath>) -> String {
    let contents = fs::read_to_string(&file_path.0)?;
    Response::build()
        .header(ContentType::CSS)
        .sized_body(contents.len(), io::Cursor::new(contents))
        .finalize()
    
}

#[launch]
fn rocket() -> _ {
    rocket::build()
        .mount("/", routes![index, clicked])
        .manage(CssFilePath("./dist/output.css".to_string()))
}
