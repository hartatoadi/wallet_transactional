# Wallet Transactional System API

## Description

This project is an internal wallet transaction system that allows users to perform deposits and withdrawals. The system supports various entities such as users, teams, and stocks, and manages transactions between wallets while ensuring compliance with ACID standards.

## Key Features

- Each entity (User, Team, Stock) has its own wallet.
- Transactions (credit/debit) are managed with strict validation.
- Uses ActiveRecord to maintain data consistency.
- API to fetch the latest stock prices via RapidAPI.

## Technologies Used

- Ruby on Rails 7.2.0
- SQLite3
- RSpec (for testing)
- Bcrypt (for password hashing)

## Installation

1. **Clone this repository:**

   ```bash
   git clone git@github.com:hartatoadi/wallet_transactional.git
   cd wallet_transactional

2. **Install dependencies:**

  ```bash
  bundle install

3. **Run database migrations:**

  ```bash
  rails db:migrate

4. **Start the server:**

  ```bash
  rails server

## API Endpoints

  ## User Authentication
  - POST /login
  Enter email and password to log in.

  ## Wallet Operations
  - GET /wallets/
  Retrieve wallet information by ID.

  - POST /transactions
  Create a new transaction (deposit or withdraw).
    Request Body :

    ```json
    {
      "amount": 100.00,
      "transaction_type": "credit", // or "debit"
      "source_wallet_id": 1,
      "target_wallet_id": 2
    }

## Stock Price API
  - GET /stock_prices
    Fetch the latest stock prices

## Library: LatestStockPrice
This library is used to fetch stock price data from RapidAPI. Available endpoints:

 - GET /price_all
  Using endpoint /any in rapidapi

Example usage :

```ruby
# Fetching all stock prices
client = LatestStockPrice::Client.new
prices = client.price_all
```

## Contributing
If you would like to contribute, please fork this repository and submit a pull request.