// =============================================
// Application-wide Constants
// =============================================

export const APP_NAME = 'Badmishop';
export const HOTLINE = '0847.143.888';
export const WEBSITE = 'FBSHOP.VN';

export const API_ENDPOINTS = {
  // Auth
  LOGIN: '/auth/login',
  REGISTER: '/auth/register',
  LOGOUT: '/auth/logout',
  ME: '/auth/me',

  // Products
  PRODUCTS: '/products',
  PRODUCT_DETAIL: (id: number | string) => `/products/${id}`,
  PRODUCT_BY_SLUG: (slug: string) => `/products/slug/${slug}`,

  // Categories
  CATEGORIES: '/categories',
  CATEGORY_DETAIL: (id: number | string) => `/categories/${id}`,
  SUBCATEGORIES: '/subcategories',

  // Brands
  BRANDS: '/brands',
  BRAND_DETAIL: (id: number | string) => `/brands/${id}`,

  // Cart
  CART: '/cart',
  CART_ADD: '/cart/add',
  CART_UPDATE: (id: number | string) => `/cart/${id}`,
  CART_REMOVE: (id: number | string) => `/cart/${id}`,
  CART_CLEAR: '/cart/clear',

  // Wishlist
  WISHLIST: '/wishlist',
  WISHLIST_ADD: '/wishlist/add',
  WISHLIST_REMOVE: (id: number | string) => `/wishlist/${id}`,

  // Orders
  ORDERS: '/orders',
  ORDER_DETAIL: (id: number | string) => `/orders/${id}`,
  ORDER_PLACE: '/orders/place',
} as const;

export const STORAGE_KEYS = {
  TOKEN: 'badmishop_token',
  USER: 'badmishop_user',
} as const;

export const QUERY_KEYS = {
  PRODUCTS: 'products',
  PRODUCT: 'product',
  CATEGORIES: 'categories',
  BRANDS: 'brands',
  CART: 'cart',
  WISHLIST: 'wishlist',
  ORDERS: 'orders',
  ME: 'me',
} as const;
