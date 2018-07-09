package Kiwi;
# ABSTRACT: Kiwi - Perl database manager for developers
our $VERSION = 0.001;

1;

__END__

=head1 NAME

Kiwi - Perl database manager for developers

=head1 SINOPSYS

In your terminal

  # enter the console command
  $ kiwi db setup --path=~/myapp/db

Kiwi CLI will look for migration files on 'migrations' folder...

  # file myapp/db/migrations/20161123133042.create_users

  create_table "users" => sub {
    text    "name", default => 'No Name';
    varchar "email", size => 80, null => 0;
    string  "password", null => 0;

    # add created_at and updated_at columns
    add_timestamps(); 
  };


=head1 DESCRIPTION

Kiwi is a simple to use, perlish and intuitive database manager
for help developers make database, tables and database changes 
versioned using a sim DSL.
