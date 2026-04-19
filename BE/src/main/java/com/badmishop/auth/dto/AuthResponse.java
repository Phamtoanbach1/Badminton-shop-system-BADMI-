package com.badmishop.auth.dto;

public record AuthResponse(
    String token,
    UserResponse user
) {
}
