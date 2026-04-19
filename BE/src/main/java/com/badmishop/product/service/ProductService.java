package com.badmishop.product.service;

import com.badmishop.product.entity.Product;
import com.badmishop.product.repository.ProductRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
public class ProductService {

    private final ProductRepository productRepository;

    public ProductService(ProductRepository productRepository) {
        this.productRepository = productRepository;
    }

    public Page<Product> getActiveProducts(int page, int limit) {
        Pageable pageable = PageRequest.of(page, limit);
        return productRepository.findByIsActiveTrue(pageable);
    }
}
