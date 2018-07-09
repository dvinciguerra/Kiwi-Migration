package Kiwi::Adapter::Sqlite;
use Object::Simple -base;

# attributes
has command => '';
has query => '';

sub create {
  my ($self, $table) = @_;
  $self->command('create');
  # ${join(', ', map { $_->to_sql } @{$table->columns})}
  my $columns = $self->_get_columns($table);
  $self->query(qq{
    CREATE TABLE '$table->{name}' (
      $columns
    );
  });

  $self
}

sub _get_columns {
  my ($self, $table) = @_;
  join ",\n", map { $_->to_sql } @{$table->columns};
  #join(', ', map { $_->to_sql } @{$table->columns});
}

sub to_sql {
  shift->query
}

1;
