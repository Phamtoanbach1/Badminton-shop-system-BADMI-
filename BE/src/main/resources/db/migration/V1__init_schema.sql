CREATE TABLE users (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(190) NOT NULL UNIQUE,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(30),
  address VARCHAR(255),
  role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_users_role CHECK (role IN ('CUSTOMER', 'ADMIN'))
);

CREATE TABLE categories (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(160) NOT NULL UNIQUE,
  description TEXT,
  image VARCHAR(255),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE subcategories (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NOT NULL,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(160) NOT NULL UNIQUE,
  description TEXT,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_subcategory_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE brands (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  slug VARCHAR(160) NOT NULL UNIQUE,
  logo VARCHAR(255),
  description TEXT,
  website VARCHAR(255),
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  category_id BIGINT NOT NULL,
  subcategory_id BIGINT NULL,
  brand_id BIGINT NULL,
  name VARCHAR(190) NOT NULL,
  slug VARCHAR(220) NOT NULL UNIQUE,
  sku VARCHAR(120) NOT NULL UNIQUE,
  description TEXT,
  price DECIMAL(12,2) NOT NULL,
  original_price DECIMAL(12,2) NULL,
  stock INT NOT NULL DEFAULT 0,
  is_active BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_product_category FOREIGN KEY (category_id) REFERENCES categories(id),
  CONSTRAINT fk_product_subcategory FOREIGN KEY (subcategory_id) REFERENCES subcategories(id),
  CONSTRAINT fk_product_brand FOREIGN KEY (brand_id) REFERENCES brands(id)
);

CREATE TABLE product_images (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  product_id BIGINT NOT NULL,
  image_url VARCHAR(255) NOT NULL,
  sort_order INT NOT NULL DEFAULT 0,
  CONSTRAINT fk_image_product FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE TABLE cart_items (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_cart_quantity CHECK (quantity > 0),
  CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_cart_product FOREIGN KEY (product_id) REFERENCES products(id),
  CONSTRAINT uq_cart_user_product UNIQUE (user_id, product_id)
);

CREATE TABLE wishlist_items (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  added_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_wishlist_user FOREIGN KEY (user_id) REFERENCES users(id),
  CONSTRAINT fk_wishlist_product FOREIGN KEY (product_id) REFERENCES products(id),
  CONSTRAINT uq_wishlist_user_product UNIQUE (user_id, product_id)
);

CREATE TABLE orders (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT NOT NULL,
  total DECIMAL(12,2) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'PENDING',
  shipping_address VARCHAR(255) NOT NULL,
  payment_method VARCHAR(60) NOT NULL,
  note VARCHAR(255),
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT chk_orders_status CHECK (status IN ('PENDING', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED')),
  CONSTRAINT fk_order_user FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE order_items (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT NOT NULL,
  product_id BIGINT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(12,2) NOT NULL,
  CONSTRAINT chk_order_item_quantity CHECK (quantity > 0),
  CONSTRAINT fk_order_item_order FOREIGN KEY (order_id) REFERENCES orders(id),
  CONSTRAINT fk_order_item_product FOREIGN KEY (product_id) REFERENCES products(id)
);

CREATE INDEX idx_products_filter ON products(category_id, subcategory_id, brand_id, is_active);
CREATE INDEX idx_products_price ON products(price);
CREATE INDEX idx_products_created_at ON products(created_at);
CREATE INDEX idx_products_name ON products(name);
CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);
CREATE INDEX idx_orders_status_created ON orders(status, created_at);
CREATE INDEX idx_cart_user ON cart_items(user_id);
CREATE INDEX idx_wishlist_user ON wishlist_items(user_id);
