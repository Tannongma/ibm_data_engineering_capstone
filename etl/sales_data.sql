CREATE TABLE IF NOT EXISTS sales_data(rowid INTEGER PRIMARY KEY NOT NULL,
                                    product_id INTEGER NOT NULL,
                                    customer_id INTEGER NOT NULL,
                                    price DECIMAL DEFAULT 0.0 NOT NULL,
									quantity INTEGER DEFAULT 0.0 NOT NULL,
                                    timestamp TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL);