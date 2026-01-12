# Billing System – Ruby on Rails

A simple billing system built using Ruby on Rails that supports CRUD operations for products and purchase invoice generation.  
The system includes validations, denomination handling, invoice email delivery.

---

## Features

- Product management (CRUD)
- Purchase invoice creation
- Tax and total amount calculation
- Cash denomination handling
- Invoice email delivery
- Backend and frontend validations

---

## Tech Stack

- Ruby on Rails
- PostgreSQL
- Action Mailer

---

## Setup Instructions

### Clone the repository

```bash
git clone https://github.com/ShaliniPriyaR/billing-system.git
cd billing-system
```

### Install dependencies
```bash
bundle install
```

### Database setup
```bash
rails db:create
rails db:migrate
rails db:seed
```

### Start the server
```bash
rails server
```

### For Verification of Mail using Mailcatcher:
```bash
gem install mailcatcher
mailcatcher #start mailcatcher
visit http://127.0.0.1:1080 
```

Visit the application at:
```bash
http://localhost:3000
```
---

## The following validations are implemented on the invoice creation page:
### Frontend Validations
- Customer email is mandatory
- At least one product must be added
- Product selection cannot be duplicated

### Backend Validations
- Mandatory field validations
- Amount comparison validations
- Stock availability checks
- Exact change validation using available denominations
- Concurrency handling using database-level locking
- Cash paid must be sufficient
- Denomination calculation must match the balance

---

## Assumptions
- Denominations in page 1 represent the cash available in the shop 
- Balance Denominations in page 2 represent the cash returned to customer after purchase
- Received and returned denominations are calculated on the backend.
- Net total is rounded down before calculating balance.
- Frontend JavaScript is minimal and embedded within views as per assignment notes.

---

## Notes
- The project follows Rails best practices with clear separation of concerns.
- No advanced CSS is used, focusing on model and view logic.
- The application runs locally without additional configuration.