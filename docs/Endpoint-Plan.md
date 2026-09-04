# RaceDay API Endpoint Plan

| HTTP method | Route | Description | Role required | Request body | Expected response |
| :--- | :--- | :--- | :--- | :--- | :--- |
| POST | `/api/auth/register` | Registers a new user as either Organiser or Participant. | None (Public) | `{ "email", "password", "fullName", "role" }` | **201 Created** - Returns user object.<br>**400 Bad Request** - Invalid fields.<br>**409 Conflict** - Email already registered. |
| POST | `/api/auth/login` | Authenticates user and returns JWT token. | None (Public) | `{ "email", "password" }` | **200 OK** - Returns JWT token.<br>**401 Unauthorized** - Invalid credentials. |
| GET | `/api/users/profile` | Retrieves the current user's profile. | Any (Logged-in) | None | **200 OK** - Returns profile.<br>**401 Unauthorized** - No token.<br>**404 Not Found** - Profile missing. |
| PUT | `/api/users/profile` | Updates the current user's profile. | Any (Logged-in) | `{ "fullName", "phone" }` | **200 OK** - Returns updated profile.<br>**400 Bad Request** - Invalid data.<br>**401 Unauthorized** - No token.<br>**404 Not Found** - Profile not found. |