package com.badmishop.auth.service;

import com.badmishop.auth.dto.AuthResponse;
import com.badmishop.auth.dto.LoginRequest;
import com.badmishop.auth.dto.RegisterRequest;
import com.badmishop.auth.dto.UserResponse;
import com.badmishop.auth.security.JwtService;
import com.badmishop.common.enums.Role;
import com.badmishop.user.entity.User;
import com.badmishop.user.repository.UserRepository;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class AuthService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final UserDetailsService userDetailsService;

    public AuthService(
        UserRepository userRepository,
        PasswordEncoder passwordEncoder,
        JwtService jwtService,
        UserDetailsService userDetailsService
    ) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtService = jwtService;
        this.userDetailsService = userDetailsService;
    }

    public AuthResponse register(RegisterRequest request) {
        String email = request.email().trim().toLowerCase();
        if (userRepository.existsByEmail(email)) {
            throw new IllegalArgumentException("Email already exists");
        }

        User user = new User();
        user.setName(request.name().trim());
        user.setEmail(email);
        user.setPasswordHash(passwordEncoder.encode(request.password()));
        user.setPhone(request.phone());
        user.setRole(Role.CUSTOMER);
        User savedUser = userRepository.save(user);

        UserDetails userDetails = userDetailsService.loadUserByUsername(savedUser.getEmail());
        String token = jwtService.generateToken(userDetails);
        return new AuthResponse(token, UserResponse.from(savedUser));
    }

    public AuthResponse login(LoginRequest request) {
        String email = request.email().trim().toLowerCase();
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new BadCredentialsException("Email hoặc mật khẩu không đúng"));

        if (!passwordEncoder.matches(request.password(), user.getPasswordHash())) {
            throw new BadCredentialsException("Email hoặc mật khẩu không đúng");
        }

        UserDetails userDetails = userDetailsService.loadUserByUsername(user.getEmail());
        String token = jwtService.generateToken(userDetails);
        return new AuthResponse(token, UserResponse.from(user));
    }

    public UserResponse getCurrentUser(String email) {
        User user = userRepository.findByEmail(email)
            .orElseThrow(() -> new BadCredentialsException("User not found"));
        return UserResponse.from(user);
    }
}
