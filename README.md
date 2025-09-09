# README

## Application Overview
This Rails 8 API accepts a file (`customers.txt`) containing customer records in JSON lines format, filters out customers within **100 km of the Mumbai office** (`19.0590317, 72.7553452`), and returns their names and user IDs sorted in ascending order by user ID.

---

## Ruby version
- Ruby **3.3+**
- Rails **8.0+**

---

## System dependencies
- Bundler (`gem install bundler`)
- PostgreSQL
---

## Configuration
Clone the repository and install gems:

```bash
git clone https://github.com/Ziyuddin030/amaha_test.git
cd amaha_test
bundle install
```

* Database creation
  - bin/rails db:create db:migrate

* Run the test suite
    - bundle exec rspec
    - rubocop -A

* Project
  - rails server
---

## Example Usage(Swagger)
 Visit http://localhost:3000/api-docs
- goto -> Api section -> "Try it now button" select customer.txt file -> Click on  "Execute" button.
- [amaha.webm](https://github.com/user-attachments/assets/5f8cefa6-1491-4073-94ec-bbaa006c43be)


## Example Usage(Postman)
 curl -X POST http://localhost:3000/api/v1/customers/nearby \
  -F "file=@customers.txt"
- goto -> body(section) -> select customer.txt file -> send request

## Documentation of API :-
I have used swagger gem to build documentation on API. Also it can upload ```customer.txt``` file.
- Link (```http://localhost:3000/api-docs```)

## Customers Data(JSON) :-
- https://assets.theinnerhour.com/take-home-test/customers.txt
