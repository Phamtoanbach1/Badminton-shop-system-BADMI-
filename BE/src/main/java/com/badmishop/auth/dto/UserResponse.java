package com.badmishop.auth.dto;

import com.badmishop.user.entity.User;
import com.fasterxml.jackson.annotation.JsonProperty;
import java.time.LocalDateTime;

public record UserResponse(
    Long id,
    String name,
    String email,
    String phone,
    String address,
    String role,
    @JsonProperty("created_at") LocalDateTime createdAt,
    @JsonProperty("updated_at") LocalDateTime updatedAt
) {
    public static UserResponse from(User user) {
        return new UserResponse(
            user.getId(),
            user.getName(),
            user.getEmail(),
            user.getPhone(),
            user.getAddress(),
            user.getRole().name().toLowerCase(),
            user.getCreatedAt(),
            user.getUpdatedAt()
        );
    }
}
