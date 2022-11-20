# Cats Shop Service

Cats Shop Service is a Ruby service for dealing with the 3-d party services that hold cat data.

## Install and run

Clone the project:

```bash
git clone https://github.com/ivanyshak/cats_shop
bundle install
rake db:migrate
rails server
```

## Usage

##### Send the request to our cats API with the *:name* and *:location* params and get the result with the desired cats selected by price in :asc order

```ruby
http://localhost:3000/api/v1/cats?name=Abyssin&location=Lviv

{
  "data": {
    "data": [
      {
          "id": 1,
          "name": "Abyssin",
          "price": 500.0,
          "location": "Lviv",
          "image": "https://olxua-ring02.akamaized.net/images_slandocomua/476948786_2_1000x700_abissenysh-chempion-fotografii.jpg",
          "created_at": "2022-11-15T10:59:00.536Z",
          "updated_at": "2022-11-15T10:59:00.536Z"
      },
      {
          "id": 2,
          "name": "Abyssin",
          "price": 550.0,
          "location": "Lviv",
          "image": "https://olxua-ring10.akamaized.net/images_slandocomua/342850976_3_1000x700_abidetki-koti_rev006.jpg",
          "created_at": "2022-11-15T10:59:00.538Z",
          "updated_at": "2022-11-15T10:59:00.538Z"
      }
    ],
    "json_error_msg": false,
    "xml_error_msg": false
  }
}

```

