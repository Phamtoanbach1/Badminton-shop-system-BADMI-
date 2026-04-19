package com.badmishop.product.repository;

import com.badmishop.product.entity.Product;
import java.util.Optional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ProductRepository extends JpaRepository<Product, Long> {
    Page<Product> findByIsActiveTrue(Pageable pageable);
    Optional<Product> findBySlugAndIsActiveTrue(String slug);
}
