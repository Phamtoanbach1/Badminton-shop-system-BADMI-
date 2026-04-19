-- =========================================================
-- V2: Development seed data for demo
-- =========================================================
-- Password hash below is BCrypt for plaintext: password123
-- =========================================================
use badmishop

-- Users
IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'admin@badmishop.com')
  INSERT INTO users (name, email, password_hash, phone, address, role)
  VALUES ('Admin Demo', 'admin@badmishop.com', '$2a$10$pQaDr9.non8YJi4CVqPpju6/iMq6hb2ZsvL8uurFGYany29s4Ha..', '0900000001', 'HCM City', 'ADMIN');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'user1@badmishop.com')
  INSERT INTO users (name, email, password_hash, phone, address, role)
  VALUES ('Nguyen Van A', 'user1@badmishop.com', '$2a$10$pQaDr9.non8YJi4CVqPpju6/iMq6hb2ZsvL8uurFGYany29s4Ha..', '0900000002', 'Thu Duc, HCM', 'CUSTOMER');

IF NOT EXISTS (SELECT 1 FROM users WHERE email = 'user2@badmishop.com')
  INSERT INTO users (name, email, password_hash, phone, address, role)
  VALUES ('Tran Thi B', 'user2@badmishop.com', '$2a$10$pQaDr9.non8YJi4CVqPpju6/iMq6hb2ZsvL8uurFGYany29s4Ha..', '0900000003', 'Bien Hoa, Dong Nai', 'CUSTOMER');

-- Categories
IF NOT EXISTS (SELECT 1 FROM categories WHERE slug = 'vot-cau-long')
  INSERT INTO categories (name, slug, description, image, is_active)
  VALUES ('Vot cau long', 'vot-cau-long', 'Danh muc vot cau long', '/images/categories/racket.jpg', 1);

IF NOT EXISTS (SELECT 1 FROM categories WHERE slug = 'giay-cau-long')
  INSERT INTO categories (name, slug, description, image, is_active)
  VALUES ('Giay cau long', 'giay-cau-long', 'Danh muc giay cau long', '/images/categories/shoes.jpg', 1);

IF NOT EXISTS (SELECT 1 FROM categories WHERE slug = 'phu-kien')
  INSERT INTO categories (name, slug, description, image, is_active)
  VALUES ('Phu kien', 'phu-kien', 'Danh muc phu kien cau long', '/images/categories/accessories.jpg', 1);

-- Subcategories
IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'vot-tan-cong')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Vot tan cong', 'vot-tan-cong', 'Vot danh tan cong', 1 FROM categories c WHERE c.slug = 'vot-cau-long';

IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'vot-toan-dien')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Vot toan dien', 'vot-toan-dien', 'Vot cong thu toan dien', 1 FROM categories c WHERE c.slug = 'vot-cau-long';

IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'vot-phong-thu')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Vot phong thu', 'vot-phong-thu', 'Vot thu dam', 1 FROM categories c WHERE c.slug = 'vot-cau-long';

IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'giay-nam')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Giay nam', 'giay-nam', 'Giay danh cho nam', 1 FROM categories c WHERE c.slug = 'giay-cau-long';

IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'giay-nu')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Giay nu', 'giay-nu', 'Giay danh cho nu', 1 FROM categories c WHERE c.slug = 'giay-cau-long';

IF NOT EXISTS (SELECT 1 FROM subcategories WHERE slug = 'quan-ao')
  INSERT INTO subcategories (category_id, name, slug, description, is_active)
  SELECT c.id, 'Quan ao', 'quan-ao', 'Trang phuc cau long', 1 FROM categories c WHERE c.slug = 'phu-kien';

-- Brands
IF NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'yonex')
  INSERT INTO brands (name, slug, logo, description, website, is_active)
  VALUES ('Yonex', 'yonex', '/images/brands/yonex.png', 'Thuong hieu Yonex', 'https://www.yonex.com', 1);

IF NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'lining')
  INSERT INTO brands (name, slug, logo, description, website, is_active)
  VALUES ('Lining', 'lining', '/images/brands/lining.png', 'Thuong hieu Lining', 'https://www.lining.com', 1);

IF NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'victor')
  INSERT INTO brands (name, slug, logo, description, website, is_active)
  VALUES ('Victor', 'victor', '/images/brands/victor.png', 'Thuong hieu Victor', 'https://www.victorsport.com', 1);

IF NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'mizuno')
  INSERT INTO brands (name, slug, logo, description, website, is_active)
  VALUES ('Mizuno', 'mizuno', '/images/brands/mizuno.png', 'Thuong hieu Mizuno', 'https://www.mizuno.com', 1);

IF NOT EXISTS (SELECT 1 FROM brands WHERE slug = 'kawasaki')
  INSERT INTO brands (name, slug, logo, description, website, is_active)
  VALUES ('Kawasaki', 'kawasaki', '/images/brands/kawasaki.png', 'Thuong hieu Kawasaki', 'https://www.kawasaki.com', 1);

-- Products (12 items)
INSERT INTO products (
  category_id, subcategory_id, brand_id, name, slug, sku, description,
  price, original_price, stock, is_active
)
SELECT c.id, sc.id, b.id, p.name, p.slug, p.sku, p.description, p.price, p.original_price, p.stock, 1
FROM (
  VALUES
    ('vot-cau-long','vot-tan-cong','yonex','Yonex Astrox 100ZZ','yonex-astrox-100zz','YON-AX100ZZ','Vot cao cap thien cong cho nguoi danh manh',4590000.00,5200000.00,20),
    ('vot-cau-long','vot-toan-dien','yonex','Yonex Arcsaber 11 Pro','yonex-arcsaber-11-pro','YON-ARC11PRO','Vot can bang, de kiem soat',3990000.00,4590000.00,16),
    ('vot-cau-long','vot-phong-thu','victor','Victor Thruster F C','victor-thruster-f-c','VIC-TFC','Vot phong thu phan xa tot',2890000.00,3290000.00,14),
    ('vot-cau-long','vot-tan-cong','lining','Lining Axforce 90','lining-axforce-90','LIN-AXF90','Vot tan cong phan khuc cao',3790000.00,4290000.00,13),
    ('vot-cau-long','vot-toan-dien','kawasaki','Kawasaki Honor S6','kawasaki-honor-s6','KAW-HS6','Vot pho thong de danh',1290000.00,1590000.00,35),
    ('vot-cau-long','vot-phong-thu','lining','Lining Windstorm 72','lining-windstorm-72','LIN-WS72','Vot nhe cho danh phong thu',1990000.00,2390000.00,22),
    ('giay-cau-long','giay-nam','mizuno','Mizuno Wave Claw Neo 2','mizuno-wave-claw-neo-2','MIZ-WCN2','Giay cau long nam cao cap',2890000.00,3290000.00,18),
    ('giay-cau-long','giay-nu','yonex','Yonex Aerus Z Women','yonex-aerus-z-women','YON-AERUSZW','Giay nhe cho nu',2490000.00,2890000.00,19),
    ('giay-cau-long','giay-nam','victor','Victor A970 NitroLite','victor-a970-nitrolite','VIC-A970N','Giay bam san va on dinh',2690000.00,3090000.00,15),
    ('phu-kien','quan-ao','yonex','Ao cau long Yonex 2026','ao-cau-long-yonex-2026','YON-TS2026','Ao thi dau thoang khi',690000.00,790000.00,40),
    ('phu-kien','quan-ao','lining','Quan short Lining Pro','quan-short-lining-pro','LIN-SHORTPRO','Quan short cho van dong',490000.00,590000.00,45),
    ('phu-kien','quan-ao','kawasaki','Tat the thao Kawasaki','tat-the-thao-kawasaki','KAW-SOCK01','Tat tham hut mo hoi',89000.00,120000.00,80)
) AS p(category_slug, sub_slug, brand_slug, name, slug, sku, description, price, original_price, stock)
JOIN categories c ON c.slug = p.category_slug
LEFT JOIN subcategories sc ON sc.slug = p.sub_slug
LEFT JOIN brands b ON b.slug = p.brand_slug
WHERE NOT EXISTS (SELECT 1 FROM products x WHERE x.slug = p.slug);

-- Product images (2 images per product)
DELETE FROM product_images
WHERE product_id IN (SELECT id FROM products);

INSERT INTO product_images (product_id, image_url, sort_order)
SELECT p.id, CONCAT('/images/products/', p.slug, '-1.jpg') AS image_url, 1
FROM products p
WHERE NOT EXISTS (
  SELECT 1 FROM product_images pi WHERE pi.product_id = p.id AND pi.image_url = CONCAT('/images/products/', p.slug, '-1.jpg') AND pi.sort_order = 1
);

INSERT INTO product_images (product_id, image_url, sort_order)
SELECT p.id, CONCAT('/images/products/', p.slug, '-2.jpg') AS image_url, 2
FROM products p
WHERE NOT EXISTS (
  SELECT 1 FROM product_images pi WHERE pi.product_id = p.id AND pi.image_url = CONCAT('/images/products/', p.slug, '-2.jpg') AND pi.sort_order = 2
);

-- Cart demo data
IF NOT EXISTS (SELECT 1 FROM cart_items WHERE user_id = (SELECT id FROM users WHERE email = 'user1@badmishop.com') AND product_id = (SELECT id FROM products WHERE slug = 'yonex-astrox-100zz'))
  INSERT INTO cart_items (user_id, product_id, quantity)
  SELECT u.id, p.id, 1
  FROM users u
  JOIN products p ON p.slug = 'yonex-astrox-100zz'
  WHERE u.email = 'user1@badmishop.com';

IF NOT EXISTS (SELECT 1 FROM cart_items WHERE user_id = (SELECT id FROM users WHERE email = 'user1@badmishop.com') AND product_id = (SELECT id FROM products WHERE slug = 'ao-cau-long-yonex-2026'))
  INSERT INTO cart_items (user_id, product_id, quantity)
  SELECT u.id, p.id, 2
  FROM users u
  JOIN products p ON p.slug = 'ao-cau-long-yonex-2026'
  WHERE u.email = 'user1@badmishop.com';

-- Wishlist demo data
IF NOT EXISTS (SELECT 1 FROM wishlist_items WHERE user_id = (SELECT id FROM users WHERE email = 'user1@badmishop.com') AND product_id = (SELECT id FROM products WHERE slug = 'mizuno-wave-claw-neo-2'))
  INSERT INTO wishlist_items (user_id, product_id)
  SELECT u.id, p.id
  FROM users u
  JOIN products p ON p.slug = 'mizuno-wave-claw-neo-2'
  WHERE u.email = 'user1@badmishop.com';

IF NOT EXISTS (SELECT 1 FROM wishlist_items WHERE user_id = (SELECT id FROM users WHERE email = 'user2@badmishop.com') AND product_id = (SELECT id FROM products WHERE slug = 'lining-axforce-90'))
  INSERT INTO wishlist_items (user_id, product_id)
  SELECT u.id, p.id
  FROM users u
  JOIN products p ON p.slug = 'lining-axforce-90'
  WHERE u.email = 'user2@badmishop.com';

-- Orders demo data (2 orders)
IF NOT EXISTS (SELECT 1 FROM orders WHERE user_id = (SELECT id FROM users WHERE email = 'user1@badmishop.com') AND total = 5280000.00 AND status = 'DELIVERED')
  INSERT INTO orders (user_id, total, status, shipping_address, payment_method, note)
  SELECT u.id, 5280000.00, 'DELIVERED', 'Thu Duc, HCM', 'cod', 'Don da giao'
  FROM users u
  WHERE u.email = 'user1@badmishop.com';

IF NOT EXISTS (SELECT 1 FROM orders WHERE user_id = (SELECT id FROM users WHERE email = 'user2@badmishop.com') AND total = 2690000.00 AND status = 'PROCESSING')
  INSERT INTO orders (user_id, total, status, shipping_address, payment_method, note)
  SELECT u.id, 2690000.00, 'PROCESSING', 'Bien Hoa, Dong Nai', 'bank_transfer', 'Dang xu ly'
  FROM users u
  WHERE u.email = 'user2@badmishop.com';

INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT o.id, p.id, 1, 4590000.00
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.slug = 'yonex-astrox-100zz'
WHERE u.email = 'user1@badmishop.com'
  AND o.id = (SELECT MAX(o2.id) FROM orders o2 JOIN users u2 ON u2.id = o2.user_id WHERE u2.email = 'user1@badmishop.com')
  AND NOT EXISTS (
    SELECT 1 FROM order_items oi WHERE oi.order_id = o.id AND oi.product_id = p.id
  );

INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT o.id, p.id, 1, 690000.00
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.slug = 'ao-cau-long-yonex-2026'
WHERE u.email = 'user1@badmishop.com'
  AND o.id = (SELECT MAX(o2.id) FROM orders o2 JOIN users u2 ON u2.id = o2.user_id WHERE u2.email = 'user1@badmishop.com')
  AND NOT EXISTS (
    SELECT 1 FROM order_items oi WHERE oi.order_id = o.id AND oi.product_id = p.id
  );

INSERT INTO order_items (order_id, product_id, quantity, price)
SELECT o.id, p.id, 1, 2690000.00
FROM orders o
JOIN users u ON u.id = o.user_id
JOIN products p ON p.slug = 'victor-a970-nitrolite'
WHERE u.email = 'user2@badmishop.com'
  AND o.id = (SELECT MAX(o2.id) FROM orders o2 JOIN users u2 ON u2.id = o2.user_id WHERE u2.email = 'user2@badmishop.com')
  AND NOT EXISTS (
    SELECT 1 FROM order_items oi WHERE oi.order_id = o.id AND oi.product_id = p.id
  );
