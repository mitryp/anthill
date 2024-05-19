# Anthill
**Anthill** is an open-source charity management system designed to enhance transparency and efficiency for small charities. This project serves as my university project for the year and as a contribution to a local charity, offering a scalable solution for managing transactions, inventory, and users.

## Features
- **Transaction Management:** Keep track of all financial transactions with ease and form stats overviews for any selected date range.
- **User Management:** Handle users and their roles.
- **Action logging:** Every action can be viewed through the logging page, providing additional transparency for the users.
- ***Planned: Humanitarian Aid accounting.***

## Technology Stack
- **Backend:** [NestJS](https://nestjs.com/) - A progressive Node.js framework for building efficient and scalable server-side applications.
- **Frontend:** [Flutter](https://flutter.dev/) - An open-source UI software development toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

## Prerequisites

- Flutter SDK to build the frontend and NodeJS to run the backend. *Docker images are on their way but are not just yet there.*
- PostgreSQL installed on your server or machine accessible through HTTP.

## Installation

### Backend (NestJS)

1. Clone the repository:
    ```bash
    git clone https://github.com/mitryp/anthill
    cd anthill/anthill_back
    ```

2. Install dependencies:
    ```bash
    npm i -y
    ```

3. Set up environment variables:
    ```bash
    cp .env.example .env
    # Update the .env with your configuration
    ```

4. Run the server:
    ```bash
    npm run start
    ```

### Frontend (Flutter)

1. Navigate to the frontend directory:
    ```bash
    cd ../frontend
    ```

2. Install dependencies and run the codegen:
    ```bash
    flutter pub get && flutter run build_runner build
    ```

3. Run the application:
    ```bash
    flutter build web --release
    ```

## Contributing

We welcome contributions from the community! To contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/your-feature`).
3. Commit your changes (`git commit -am 'Add some feature'`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Create a new Pull Request.

## License

This project is licensed under the Apache License - see the [LICENSE](LICENSE) file for details.
