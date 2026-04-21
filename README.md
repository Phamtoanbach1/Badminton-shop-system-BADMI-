# Badmishop E-Commerce

This repository contains a full-stack badminton shop project with:

- `BE/`: Spring Boot backend (Java 17, Spring Security, JPA, Flyway, SQL Server)
- `FE/`: React + Vite frontend (TypeScript, Axios, React Router, React Query)

## Features

- Authentication and authorization
- Product catalog, categories, brands
- Cart, wishlist, orders
- Admin dashboard components
- Swagger API documentation

## Run Backend

From `BE/`:

```bash
mvn -Dspring-boot.run.profiles=prod spring-boot:run
```

Default SQL Server connection is:

```text
jdbc:sqlserver://localhost:1433;databaseName=badmishop;encrypt=false;trustServerCertificate=true
```

If you want to override credentials:

```bash
mvn -Dspring-boot.run.profiles=prod -DDB_USERNAME=sa -DDB_PASSWORD=123 spring-boot:run
```

Swagger UI:

```text
http://localhost:8080/swagger-ui/index.html
```

## Run Frontend

From `FE/`:

```bash
npm install
npm run dev
```

Open:

```text
http://localhost:5173
```



## Git Branching

- `main`: production-ready default branch
- `Bach`: current working branch with latest FE and BE fixes
