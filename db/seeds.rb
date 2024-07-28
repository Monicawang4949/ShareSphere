Admin.find_or_create_by!(
   email: 'admin@example.com',
   password: '123abc'
)
User.find_or_create_by!(
  [
   {email: 'mary@example.com', name: 'Mary', password: '123456'},
   {email: 'lily@example.com', name: 'Lily', password: '123456'},
   {email: 'lucy@example.com', name: 'Lucy', password: '123456'},
   {email: 'jack@example.com', name: 'Jack', password: '123456'},
   {email: 'Jam@example.com', name: 'Jam', password: '123456'},
   {email: 'david@example.com', name: 'David', password: '123456'},
   {email: 'leo@example.com', name: 'Leo', password: '123456'},
   {email: 'tony@example.com', name: 'Tony', password: '123456'},
   {email: 'lisa@example.com', name: 'Lisa', password: '123456'},
   {email: 'daisy@example.com', name: 'Daisy', password: '123456'},
  ]
)