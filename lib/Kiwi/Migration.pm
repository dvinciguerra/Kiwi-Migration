use Kiwi::Adapter::Sqlite;
use strict;

package Kiwi::Migration;

use 5.10.0;

# export this shits
use Exporter 'import';
# column varchar string text char integer real bool
our @EXPORT = our @EXPORT_OK = qw(create_table drop_table add_timestamps text varchar);

use Data::Dumper;
use Lingua::EN::Inflexion;

# table
my $table = Kiwi::Table->new;


# CREATE TABLE
sub create_table {
  my ($name, $table_cb) = @_;
  
  $table = Kiwi::Table->new(name => $name);
  add_primary($name);

  # do other tasks with table
  $table_cb->();
  say $table->create();
}


# DROP TABLE
sub drop_table {
  my ($name) = @_;
  my $table = Kiwi::Table->new(name => $name);
  say $table->drop();
}

# ALTER TABLE
sub alter_table {
  my ($name, $table_cb) = @_;
  
  $table = Kiwi::Table->new(name => $name);

  # do other tasks with table
  $table_cb->();
  say $table->alter();
}


# ADD created_at AND updated_at
sub add_timestamps {
  # created_at column
  $table->add_column(
    'created_at',
    type    => 'timestamp',
    null    => 0
  );

  # updated_at column
  $table->add_column(
    'updated_at',
    type    => 'timestamp',
    null    => 0
  );
}


# ADD PRIMARY KEY
sub add_primary {
  my $name = shift;
  $name = noun($name)->singular . "_id";
  $table->add_column(
    $name,
    type    => 'primary',
    null    => 0
  );
}


# adding column type aliases
for my $m  (qw(text varchar)) {
  eval qq{ 
    sub $m {
      my \$name = shift;
      my \$opts = \@_ % 2 == 0? {\@_} : {};
      \$table->add_column(
        \$name,
        type    => "$m",
        value   => \$opts->{value}, 
        size    => \$opts->{size},
        null    => \$opts->{null}
      );
    }
  }
}

package Kiwi::Table;
use Object::Simple -base;

# attributes
has name => '';
has columns => sub{ [] };
has adapter => sub { Kiwi::Adapter::Sqlite->new };

# methods
sub create {
  my $self = shift;
  # TODO: create query
  my $adapter = $self->adapter;
  $adapter->create($table)->to_sql
}

sub alter {
  # TODO: alter query
  shift->to_sql
}

sub drop {
  "DROP TABLE ${_[0]->name}"
}

sub add_column {
  my ($self, $name) = (shift, shift);
  my $opts = @_ % 2 == 0? {@_} : {};
  push @{$self->columns}, Kiwi::Column->new({
    name    => $name,
    type    => $opts->{type},
    value   => $opts->{value}, 
    size    => $opts->{size},
    null    => $opts->{null} || 1
  });
  $self
}

sub to_sql {
  my $self = shift;
  $self;
}

package Kiwi::Column;
use Object::Simple -base;

# attributes
has name => '';
has type => '';
has size => 0;
has null => 1;
has 'value';

sub to_sql {
  my ($self, $transpiler) = @_;
  # $transpiler->compile($self)
  # "${uc($self->type)} $self->{name}"
  $self->name ." ". $self->type;
}

1;
