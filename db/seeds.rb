# db/seeds.rb

# Create an admin user
admin = User.create!(
  name: 'Ridham Admin',
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password'
)
admin.add_role(:admin)

# Create a department for the employees
department1 = Department.create!(name: 'Engineering')
department2 = Department.create!(name: 'Marketing')

# Helper method to create employees
def create_employee_with_user(admin, first_name, last_name, email, designation, department)
  user = User.create!(
    name: "#{first_name} #{last_name}",
    email: email,
    password: 'default_password',
    password_confirmation: 'default_password'
  )
  user.add_role(:employee)

  Employee.create!(
    first_name: first_name,
    last_name: last_name,
    email: email,
    designation: designation,
    department_id: department.id,
    user_id: user.id,
    reference_by_id: admin.id
  )
end

# Create sample employees
create_employee_with_user(admin, 'Prince', 'Kathiriya', 'prince@example.com', 'Software Developer', department1)
create_employee_with_user(admin, 'Anjali', 'Patel', 'anjali@example.com', 'BDE', department2)
create_employee_with_user(admin, 'Rohan', 'Shah', 'rohan@example.com', 'Project Manager', department1)
