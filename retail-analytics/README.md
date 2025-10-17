# Retail Analytics Semantic Model

A comprehensive Lens semantic model for retail analytics covering customers, products, transactions, and stores.

## 📊 Model Overview

This semantic model provides a complete retail analytics solution with rich dimensional analysis and key business metrics.

### Data Sources
- **Database:** `retaildb.public`
- **Catalog:** Lakehouse (via Minerva)
- **Cluster:** minervac

## 🏗️ Data Model Structure

### Entity-Relationship Diagram

```
┌────────────┐         ┌──────────────┐         ┌──────────┐
│  Customers │         │ Transactions │         │  Stores  │
│            │◄───M:1──┤              ├───M:1──►│          │
│ id (PK)    │         │ id (PK)      │         │ id (PK)  │
└────────────┘         │ customer_id  │         └──────────┘
                       │ product_id   │
                       │ store_id     │
                       └──────┬───────┘
                              │
                            M:1
                              │
                       ┌──────▼───────┐
                       │   Products   │
                       │              │
                       │ id (PK)      │
                       └──────────────┘
```

## 📁 Directory Structure

```
retail-analytics/
├── retail-analytics-lens.yaml          # Main Lens manifest
├── model/
│   ├── sqls/                           # SQL source definitions
│   │   ├── customers.sql
│   │   ├── products.sql
│   │   ├── transactions.sql
│   │   └── stores.sql
│   ├── tables/                         # Table definitions with dimensions/measures
│   │   ├── customers.yaml
│   │   ├── products.yaml
│   │   ├── transactions.yaml
│   │   └── stores.yaml
│   ├── views/                          # Business metrics views
│   │   └── sales_metrics.yaml
│   └── user_groups.yml                 # Access control configuration
└── README.md                           # This file
```

## 📋 Tables

### 1. Customers
**Description:** Customer profiles and demographics

**Key Dimensions:**
- Customer identification (id, customer_code)
- Personal info (name, email, phone, address) - *PII protected*
- Demographics (gender, date_of_birth, location)
- Segmentation (customer_segment, loyalty_tier)
- Lifecycle (registration_date, last_purchase_date)

**Measures:**
- Customer count
- Total lifetime value
- Average lifetime value

**Segments:**
- Active customers
- Premium customers
- Gold loyalty customers

**Security:**
- Email, phone, and address fields are redacted for users not in `customer_data_access` group

---

### 2. Products
**Description:** Product catalog and inventory

**Key Dimensions:**
- Product identification (id, product_code, product_name)
- Classification (category, subcategory, brand)
- Pricing (unit_price, cost_price) - *Cost price protected*
- Physical attributes (weight, dimensions, color, size)
- Inventory (stock_quantity, reorder_level)
- Status and lifecycle

**Measures:**
- Product count
- Total stock quantity
- Average unit price
- Total inventory value

**Segments:**
- Active products
- Low stock products
- Electronics category

**Security:**
- Cost price field is redacted for users not in `financial_data_access` group

---

### 3. Stores
**Description:** Store locations and details

**Key Dimensions:**
- Store identification (id, store_code, store_name)
- Location (address, city, state, country, region)
- Classification (store_type, store_size_sqft)
- Management (manager_name, contact info)
- Status and opening date

**Measures:**
- Store count
- Total store size
- Average store size

**Segments:**
- Active stores
- Flagship stores

---

### 4. Transactions (Fact Table)
**Description:** Sales transactions linking all entities

**Key Dimensions:**
- Transaction identification (id, transaction_code)
- Relationships (customer_id, product_id, store_id)
- Temporal (transaction_date, transaction_time)
- Financial (unit_price, discount, tax, total_amount)
- Payment (payment_method, payment_status)
- Classification (transaction_type, sales_channel)

**Measures:**
- Transaction count
- Total revenue
- Total quantity sold
- Average transaction value
- Total discount given
- Total tax collected
- Average discount percentage
- Profit margin (calculated using product cost price)

**Segments:**
- Completed transactions
- Online transactions
- High-value transactions (>$1000)
- Return transactions

**Joins:**
- Many-to-one with customers
- Many-to-one with products
- Many-to-one with stores

---

## 📊 Views (Analytics Layer)

### 1. daily_sales_performance
**Purpose:** Daily sales KPIs across all dimensions
- **Refresh:** Daily at 2 AM UTC
- **Granularity:** Day
- **Dimensions:** Transactions, stores, products, customers
- **Key Metrics:** Revenue, transaction count, quantities, discounts, taxes

### 2. product_performance
**Purpose:** Product-level sales and inventory
- **Refresh:** Daily at 3 AM UTC
- **Granularity:** Day
- **Focus:** Product sales velocity and stock levels

### 3. customer_insights
**Purpose:** Customer behavior and lifetime value
- **Refresh:** Every 24 hours
- **Focus:** Customer segmentation, purchase patterns, LTV
- **Features:** Time-series analysis enabled for Iris

### 4. store_performance
**Purpose:** Store-level performance metrics
- **Refresh:** Daily at 4 AM UTC
- **Granularity:** Day
- **Focus:** Store sales, efficiency, regional analysis

---

## 👥 User Groups & Access Control

### 1. customer_data_access
- **Purpose:** Access to customer PII (email, phone, address)
- **Users:** Data stewards, privacy officers
- **Scopes:** Full API access

### 2. financial_data_access
- **Purpose:** Access to cost prices and profit margins
- **Users:** Finance managers, CFO
- **Scopes:** Full API access

### 3. store_manager
- **Purpose:** Store-specific operational data
- **Users:** Store managers
- **Scopes:** Limited to meta, data, graphql

### 4. analyst
- **Purpose:** Aggregated data for business analysis
- **Users:** Business and data analysts
- **Scopes:** Limited to meta, data, graphql

### 5. default
- **Purpose:** Basic access for all users
- **Users:** All (wildcard)
- **Scopes:** Full API access
- **Note:** Sensitive fields are still redacted based on group membership

---

## 🏷️ DataOS Tags

- **Domain:** `Domain.Retail`, `Domain.Sales`
- **Use Cases:** `DPUsecase.Sales Analytics`, `DPUsecase.Product Analytics`, `DPUsecase.Customer Analytics`, `DPUsecase.Store Analytics`
- **Tier:** `DPTier.Consumer Aligned`

---

## 🚀 Deployment

### Prerequisites
1. Access to Bitbucket repository
2. Instance secret `bitbucket-r` configured in DataOS
3. Minerva cluster `minervac` access
4. Source tables exist in `retaildb.public` schema

### Deployment Command
```bash
dataos-ctl apply -f retail-analytics-lens.yaml -w <workspace>
```

### Verify Deployment
```bash
dataos-ctl get -t lens -w <workspace>
dataos-ctl get -t lens -n retail-analytics -w <workspace>
```

---

## 📈 Key Business Metrics

### Revenue Metrics
- Total revenue (by store, product, customer segment, time)
- Average transaction value
- Discount effectiveness
- Tax collection

### Operational Metrics
- Sales velocity by product
- Inventory turnover
- Store performance comparison
- Channel performance (online vs in-store)

### Customer Metrics
- Customer lifetime value
- Segmentation analysis
- Loyalty tier distribution
- Purchase frequency

### Product Metrics
- Best sellers by category/brand
- Inventory levels
- Profit margins
- Stock health

---

## 🔐 Security & Compliance

### PII Protection
- Customer email, phone, and address fields are redacted by default
- Access granted only to `customer_data_access` group members

### Financial Data Protection
- Product cost prices are redacted by default
- Profit margin calculations available only to `financial_data_access` group

### Audit Trail
- All tables include `created_at` and `updated_at` timestamps
- Transaction history maintained for compliance

---

## 📞 Support

For issues or questions:
1. Check DataOS documentation
2. Contact data platform team
3. Review Lens semantic layer guides

---

## 📝 Change Log

### Version 1.0 (Initial Release)
- Complete data model with 4 tables
- 4 analytical views
- 5 user groups with role-based access
- Security controls for PII and financial data
- Comprehensive business metrics

