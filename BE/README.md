# Badmishop Backend (Spring Boot Layered)

## Tech stack
- Spring Boot 3
- Java 17
- Spring Web, Validation, Security, JPA
- Flyway + SQL Server
- Swagger/OpenAPI (springdoc)

## Quick start
1. Run SQL Server:
   - `docker compose up -d`
2. Start backend:
   - `mvn spring-boot:run`
3. Open Swagger:
   - `http://localhost:8080/swagger-ui/index.html`

## Profiles
- Default profile is `dev` (H2 in-memory, no Flyway) so app can start without SQL Server.
- Production profile uses SQL Server + Flyway:
  - `mvn spring-boot:run -Dspring-boot.run.profiles=prod`

## Environment variables
- `DB_URL` (default `jdbc:sqlserver://localhost:1433;databaseName=badmishop;encrypt=false;trustServerCertificate=true`)
- `DB_USERNAME` (default `sa`)
- `DB_PASSWORD` (default `YourStrong@Passw0rd`)
- `PORT` (default `8080`)

## Initial modules
- `config`: security and OpenAPI
- `common`: shared response and enums
- `user`: user entity/repository
- `product`: product entity/repository/service/controller

This is a bootstrap foundation, ready for adding auth/cart/wishlist/order/admin modules.
