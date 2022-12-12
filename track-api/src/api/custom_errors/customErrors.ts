export class CustomAuthError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Auth Error";
  }
}

export class CustomBadRequestError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Bad request";
  }
}

export class CustomConflictError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "conflict";
  }
}

export class CustomNotFoundError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Not Found";
  }
}

export class CustomValidationError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "Validation Error";
  }
}
