CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE brands (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	name TEXT NOT NULL,
	slug TEXT NOT NULL UNIQUE,
	PRIMARY KEY (id)
);

CREATE TABLE products (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	name TEXT,
	slug TEXT NOT NULL UNIQUE,
	brand_id UUID,
	mass DOUBLE PRECISION, -- in kilograms
	volume DOUBLE PRECISION, -- in liters
	PRIMARY KEY (id),
	FOREIGN KEY (brand_id) REFERENCES brands (id)
);

CREATE TABLE data_sources (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	name TEXT NOT NULL,
	slug TEXT NOT NULL UNIQUE,
	url TEXT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE ingredients_lists (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	-- if there is no ingredients list attached to a product
	-- then we consider the list to be unknown
	product_id UUID NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (product_id) REFERENCES products (id)
);

CREATE TABLE ingredients (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	slug TEXT NOT NULL UNIQUE,
	latin_name TEXT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE products_in_ingredients_lists (
	ingredients_list_id UUID NOT NULL,
	ingredient_id UUID NOT NULL,
	PRIMARY KEY (ingredients_list_id, ingredient_id),
	FOREIGN KEY (ingredients_list_id) REFERENCES ingredients_lists (id),
	FOREIGN KEY (ingredient_id) REFERENCES ingredients (id)
);

CREATE TABLE products_in_data_sources (
	product_id UUID NOT NULL,
	data_source_id UUID NOT NULL,
	reference_url TEXT,
	image_url TEXT,
	price NUMERIC(10, 2),
	PRIMARY KEY (product_id, data_source_id),
	FOREIGN KEY (product_id) REFERENCES products (id),
	FOREIGN KEY (data_source_id) REFERENCES data_sources (id)
);

CREATE TABLE categories (
	id UUID DEFAULT uuid_generate_v4() NOT NULL,
	slug TEXT NOT NULL UNIQUE,
	name TEXT NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE products_categories (
	product_id UUID NOT NULL,
	category_id UUID NOT NULL,
	PRIMARY KEY (product_id, category_id),
	FOREIGN KEY (product_id) REFERENCES products (id),
	FOREIGN KEY (category_id) REFERENCES categories (id)
);
