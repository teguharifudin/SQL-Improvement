#!/bin/bash

echo "Setting up database..."
mysql < /vagrant/scripts/setup_db.sql

echo "Running test queries..."
mysql < /vagrant/scripts/test_query.sql
