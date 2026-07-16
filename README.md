# Cognizant Digital Nurture 5.0

This repository contains my assignments for the **Cognizant Digital Nurture 5.0** training program.

---

## 📁 WEEK-1_ASSIGNMENTS

This folder combines all Week 1, Week 2, and Advanced SQL assignments, organized into three sub-sections:

---

### 📂 Design_Patterns

This section contains solutions covering various **Design Patterns** in Java.

| Exercise | Pattern | Description |
|----------|---------|-------------|
| Exercise 1 | **Singleton Pattern** | Implemented a `Logger` utility class ensuring only one instance exists throughout the application lifecycle. |
| Exercise 2 | **Factory Method Pattern** | Developed a document management system to create Word, PDF, and Excel documents via a unified factory interface. |
| Exercise 3 | **Builder Pattern** | Created a system to construct complex `Computer` objects with multiple optional parts (CPU, RAM, Storage, GPU, etc.). |
| Exercise 4 | **Adapter Pattern** | Built a payment processing system integrating multiple third-party gateways (PayPal, Stripe, Square) with different interfaces. |
| Exercise 5 | **Decorator Pattern** | Implemented a notification system where SMS and Slack channels can be dynamically stacked on top of a base Email notifier. |
| Exercise 6 | **Proxy Pattern** | Developed an image viewer using a proxy to add lazy initialization and caching for high-resolution remote images. |
| Exercise 7 | **Observer Pattern** | Created a stock market monitoring app where Mobile and Web displays are automatically notified when stock prices change. |
| Exercise 8 | **Strategy Pattern** | Built a flexible payment system where algorithms (Credit Card, PayPal) can be selected and swapped at runtime. |
| Exercise 9 | **Command Pattern** | Implemented a home automation system where requests (Light on/off) are encapsulated as objects and triggered via a Remote Control. |
| Exercise 10 | **MVC Pattern** | Designed a student records app separating data (`Student`), presentation (`StudentView`), and logic (`StudentController`). |
| Exercise 11 | **Dependency Injection** | Developed a customer management service with constructor-based injection to decouple components. |

---

### 📂 Data_Structures_and_Algorithms

This section covers **Data Structures and Algorithms** exercises in Java.

| Exercise | Topic | Concepts Covered |
|----------|-------|-----------------|
| Exercise 1 | Inventory Management System | HashMap, CRUD operations, O(1) lookups |
| Exercise 2 | E-commerce Platform Search | Linear Search, Binary Search, Big O Notation |
| Exercise 3 | Sorting Customer Orders | Bubble Sort, Quick Sort, Time Complexity |
| Exercise 4 | Employee Management System | Arrays, Memory Representation, CRUD with Arrays |
| Exercise 5 | Task Management System | Singly Linked List, Dynamic Data Structures |
| Exercise 6 | Library Management System | Search Algorithms on Strings (Book Titles) |
| Exercise 7 | Financial Forecasting | Recursion, Iterative Optimization |

---

### 📂 Advanced_SQL

This section contains PL/SQL exercises for a **Banking Management System** covering 7 core PL/SQL concepts through practical banking scenarios.

| File | Topic |
|------|-------|
| Schema_Setup.sql | Database schema initialization |
| Exercise1_ControlStructures.sql | IF/ELSIF/ELSE, LOOP, WHILE, FOR |
| Exercise2_ErrorHandling.sql | EXCEPTION blocks, RAISE, custom exceptions |
| Exercise3_StoredProcedures.sql | Stored procedures with IN/OUT parameters |
| Exercise4_Functions.sql | PL/SQL functions and return values |
| Exercise5_Triggers.sql | BEFORE/AFTER DML triggers |
| Exercise6_Cursors.sql | Explicit and implicit cursors |
| Exercise7_Packages.sql | Package specification and body |

---

## 📁 WEEK-2_ASSIGNMENTS

This folder contains assignments for **Spring Core and Maven**.

---

### 📂 Assignments_Spring_Core_and_Maven

| Exercise | Topic | Key Concepts |
|----------|-------|-------------|
| Exercise 1 | Configuring a Basic Spring Application | Maven project setup, Spring Context, XML bean definitions |
| Exercise 2 | Implementing Dependency Injection | IoC, Setter Injection, `<property>` wiring in XML |
| Exercise 3 | Implementing Logging with Spring AOP | `@Aspect`, `@Around` advice, execution time tracking |
| Exercise 4 | Creating and Configuring a Maven Project | `pom.xml` with Spring Context/AOP/WebMVC, Maven Compiler Plugin |
| Exercise 5 | Configuring the Spring IoC Container | IoC container lifecycle, bean management, setter injection |
| Exercise 6 | Configuring Beans with Annotations | `@Service`, `@Repository`, `@Autowired`, component scanning |
| Exercise 7 | Constructor and Setter Injection | `<constructor-arg>`, `<property>`, both injection types |
| Exercise 8 | Implementing Basic AOP with Spring | `@Before`, `@After` advice, AspectJ auto-proxying |
| Exercise 9 | Creating a Spring Boot Application | Spring Boot, REST API, Spring Data JPA, H2 Database, CRUD |

#### Exercise 9 — REST API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/books` | Get all books |
| GET | `/api/books/{id}` | Get book by ID |
| POST | `/api/books` | Add a new book |
| PUT | `/api/books/{id}` | Update a book |
| DELETE | `/api/books/{id}` | Delete a book |
| GET | `/api/books/search/author?author=` | Search by author |
| GET | `/api/books/search/title?keyword=` | Search by title keyword |

---

### 📂 Assignment_Spring_Data_JPA_with_Hibernate

This folder contains exercises for **Spring Data JPA and Hibernate** across two main projects:

#### 1. `orm-learn` Project
A comprehensive hands-on project exploring JPA mapping, query methods, and Hibernate configurations.
- **Entities & Mappings**: `Country`, `Stock`, Payroll system (`Employee`, `Department`, `Skill`), and Quiz attempt tables (`User`, `Attempt`, `Question`, `Options`).
- **Features Implemented**:
  - Derived Query Methods (Search containing text, sorting, greater than, dates).
  - O/R Mapping: `@ManyToOne`, `@OneToMany`, `@ManyToMany`, `FetchType.EAGER` vs `LAZY`.
  - Advanced Querying: Hibernate Query Language (HQL), JPQL, Native Queries.
  - Exception handling with `@Transactional` services.

#### 2. `EmployeeManagementSystem` Project
A 10-exercise Spring Boot project integrating Data JPA with REST APIs.
- **Features Implemented**:
  - Full CRUD operations via `JpaRepository`.
  - Custom Query methods with `@Query` and `@NamedQuery`.
  - Pagination and Sorting (`Pageable` and `Sort`).
  - Entity Auditing (`@EnableJpaAuditing`, `@CreatedDate`, `@LastModifiedDate`).
  - Projections (Interface-based projections).
  - Externalized Configuration & Hibernate-specific features (Dialect, DDL).

---

### 📂 WEEK-3_ASSIGNMENTS (ASSIGNMENT_spring_REST_using_Spring_Boot)

This folder contains a complete implementation of **Spring REST with Spring Boot**, structured as a single evolving project (`spring-learn`).

#### `spring-learn` Project Features
- **Spring Core Configuration**:
  - Utilizing XML configuration (`date-format.xml`, `country.xml`, `employee.xml`) in conjunction with Spring Boot.
  - Exploring Singleton vs Prototype Bean Scopes.
- **RESTful Endpoints**:
  - `HelloController`: Basic `/hello` GET mapping.
  - `CountryController`: Full suite of GET/POST operations with `@RequestBody`.
  - `EmployeeController` & `DepartmentController`: Emulating a backend API interacting with populated DAOs.
- **Validation & Exception Handling**:
  - Utilizing Java validation (`@NotNull`, `@Size`, `@Valid`) on payload bindings.
  - Implementing a **Global Exception Handler** (`@ControllerAdvice`) to gracefully handle invalid payloads (`handleMethodArgumentNotValid` and `handleHttpMessageNotReadable`) returning formatted 400 Bad Request JSON.
  - Custom exceptions (`CountryNotFoundException`) returning 404 Not Found.
- **Security & JWT Authorization**:
  - Protecting APIs with **Spring Security** (`@EnableWebSecurity`) and HTTP Basic Auth.
  - In-memory users (`admin`, `user`) hashed with `BCryptPasswordEncoder`.
  - Creating an `/authenticate` endpoint to generate **JSON Web Tokens (JWT)** via `jjwt` library.
  - Implementing a custom `JwtAuthorizationFilter` to parse bearer tokens and establish security context per request.
- **Automated Testing**:
  - Full suite of **MockMVC** tests (`@AutoConfigureMockMvc`) for validating 200 OK responses, verifying JSON payloads (`jsonPath`), and confirming correct exceptional scenarios (400 Bad Request / 404 Not Found).

---

### 📂 WEEK-4_ASSIGNMENTS (Spring Cloud & Microservices)

This folder contains a comprehensive implementation of **Spring Cloud and Microservices** spanning 4 project suites with **15 Spring Boot applications**.

#### 1. `microservices-basics/`
A complete microservice ecosystem with service discovery:
- **`eureka-server`** – Netflix Eureka Service Registry (port 8761).
- **`account-service`** – REST API for account data (port 8080), registered with Eureka.
- **`loan-service`** – REST API for loan data (port 8081), registered with Eureka.
- **`greet-service`** – Simple greeting API (dynamic port), registered with Eureka.
- **`api-gateway`** – Spring Cloud Gateway (port 9090) with Discovery Locator and custom `LogFilter`.

#### 2. `gateway-and-resilience/`
Advanced API Gateway with fault tolerance:
- **`resilient-gateway`** – Spring Cloud Gateway with Resilience4j Circuit Breaker, TimeLimiter, custom route configuration, logging filters, and fallback controller.

#### 3. `oauth2-and-jwt/`
Spring Security with modern authentication patterns:
- **`oauth2-client`** – Google OAuth2 Login integration with `@EnableWebSecurity`.
- **`resource-server`** – OAuth2 Resource Server validating JWTs.
- **`jwt-auth-service`** – Custom JWT generation (`jjwt` 0.11.5), `JwtAuthFilter`, in-memory users, stateless sessions.

#### 4. `microservices-advanced/`
Enterprise-grade microservice patterns:
- **`config-server`** – Spring Cloud Config Server (native profile) serving centralized configuration.
- **`user-service`** – Communicates with Order Service via **OpenFeign** (`@FeignClient`).
- **`order-service`** – Order management REST API registered with Eureka.
- **`product-service`** – Reads config from Config Server (`spring.config.import`).
- **`inventory-service`** – Stock/inventory lookup API.
- **`payment-service`** – Payment processing with **Resilience4j** `@CircuitBreaker` and fallback methods.

---

## 📁 WEEK-5_ASSIGNMENTS

This folder contains assignments for **ReactJS Hands-on Lab**.

### 📂 7. ReactJS-HOL

| App | Description | Key Concepts |
|-----|-------------|--------------|
| `Q1_officespacerentalapp` | Office space details display | JSX, Inline CSS, Conditional Styling |
| `Q2_cricketapp` | Cricket player listing | ES6 `map()`, Arrow Functions, Destructuring, Spread Operator |
| `Q3_counterapp` | Mall entry/exit counter | Class Components, React State |
| `Q4_shoppingapp` | Shopping cart display | Props, Component Composition |
| `Q5_trainersapp` | Academy trainers directory | React Router DOM, URL Parameters (`useParams`) |
| `Q6_cohorttracker` | Cohort details display | CSS Modules, Styling components |
| `Q7_scorecalculatorapp` | Student score calculation | Function Components |
| `Q8_studentapp` | Student portal static pages | Class Components, Multiple components |
| `Q9_blogapp` | Fetching and displaying blog posts | Component Lifecycle (`componentDidMount`, `componentDidCatch`), Fetch API |

---

> **Program**: Cognizant Digital Nurture 5.0  
> **Language**: Java (Exercises), PL/SQL (Database), ReactJS (Frontend)
