# Employee Reimbursement Portal

## Overview

This Rails 7 application is designed for an employee reimbursement portal that allows employees to submit bills and enables account admins to review and settle reimbursement claims.

## Features

- **User Authentication**: Sign-in functionality for users with roles `admin` or `employee`.
- **Employee Management**: Admins can list, create, update, and delete employee records.
- **Bill Submission**: Employees can submit reimbursement bills with types such as Food, Travel, and Others.
- **Bill Review**: Employees can view their submitted bills and their statuses.
- **Admin Bill Management**: Admins can view all bills, and approve or reject them.

## Technologies Used

- Ruby on Rails 7
- Bootstrap for styling
- PostgreSQL (or another database of your choice)
- Devise for authentication
- Rolify for role management
- CanCanCan for authorization

## Setup

1. **Clone the Repository**

git clone https://github.com/Ridham151101/ERP.git
cd ERP

2. **Install Dependencies**

bundle install

3. **Setup Database**

rails db:create
rails db:migrate

4. **Seed the Database**

rails db:seed

5. **Start the Rails Server**

rails server


### Navigate to http://localhost:3000 in your browser to view the application.

## Usage

### User Roles

- **Admin**: Can manage employees and review all submitted bills.
- **Employee**: Can submit bills and view their own submitted bills.

### Sign-In

Access the application at `http://localhost:3000`. Use the following credentials to sign in:

- **Admin**:
  - **Email**: `admin@example.com`
  - **Password**: `password`

- **Employee**:
  - **Email**: `employee@example.com`
  - **Password**: `password`

### Access Control

- **Admin**:
  - `/employees`: List and manage employees.
  - `/admin_bills`: View all bills and manage their status.

- **Employee**:
  - `/bills/new`: Submit a new bill.
  - `/bills`: View submitted bills and their statuses.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes.
