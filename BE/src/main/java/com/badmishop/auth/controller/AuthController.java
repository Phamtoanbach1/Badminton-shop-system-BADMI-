package com.badmishop.auth.controller;

import com.badmishop.auth.dto.AuthResponse;
import com.badmishop.auth.dto.LoginRequest;
import com.badmishop.auth.dto.RegisterRequest;
import com.badmishop.auth.dto.UserResponse;
import com.badmishop.auth.service.AuthService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import java.security.Principal;
import java.util.Map;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@Tag(name = "Auth", description = "Authentication APIs")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    @Operation(summary = "Register new customer account")
    public AuthResponse register(@Valid @RequestBody RegisterRequest request) {
        return authService.register(request);
    }

    @PostMapping("/login")
    @Operation(summary = "Login with email/password")
    public AuthResponse login(@Valid @RequestBody LoginRequest request) {
        return authService.login(request);
    }

    @GetMapping("/me")
    @Operation(summary = "Get current authenticated user")
    public UserResponse me(Principal principal) {
        return authService.getCurrentUser(principal.getName());
    }

    @PostMapping("/logout")
    @Operation(summary = "Logout current user")
    public Map<String, String> logout() {
        return Map.of("message", "Logged out successfully");
    }
}
