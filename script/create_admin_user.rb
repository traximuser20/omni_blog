#!/usr/bin/env ruby

# Simple script to create an admin user directly in the database
# This avoids needing to run migrations that add trackable columns

require 'active_record'

# Connect to the development database
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'omni_blog_development',
  username: 'postgres',
  password: 'password',
  host: 'localhost'
)

# Define the AdminUser model (simplified)
class AdminUser < ActiveRecord::Base
  self.table_name = 'admin_users'

  def self.create_admin!
    admin = AdminUser.find_by(email: 'admin@example.com')
    if admin
      admin
    else
      new(
        email: 'admin@example.com',
        encrypted_password: BCrypt::Password.create('password123'),
        reset_password_token: nil,
        reset_password_sent_at: nil,
        remember_created_at: nil,
        created_at: Time.current,
        updated_at: Time.current
      ).tap(&:save)
    end
  end
end

# Create the admin user
begin
  admin_user = AdminUser.create_admin!
  puts "✅ Admin user created successfully!"
  puts "📧 Email: admin@example.com"
  puts "🔑 Password: password123"
  puts "🌐 Login URL: http://localhost:3000/admin/login"
rescue => e
  puts "❌ Failed to create admin user: #{e.message}"
  puts "Backtrace: #{e.backtrace.join("\n")}"
end