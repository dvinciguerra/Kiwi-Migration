use 5.10.0;

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/lib" }

use Kiwi::Migration;

# create users table (user_id primary_key is default)
create_table "users" => sub {
  text "name", value => 'Foo';
  varchar "email", size => 80, null => 0;
  text "password", null => 0;
  add_timestamps(); # add created_at and updated_at columns
};

# alter table
#alter_table "users" => sub {
#  # change column
#  alter_column "name", type => 'text';
#  # remove column
#  drop_column "name";
#  # add column
#  add_column "name", type => 'string';
#};

# truncate_table 'users';

# drop table
# drop_table 'users';

# default database input
#execute "INSERT INTO users VALUES (:name, :email, :password)", 
#  {name => 'Joe Doe', email => 'joe@doe.com', password => 'foobarqux'}


#kiwi g model User name:string description:text readed_at:datetime
