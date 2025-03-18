package TodoAPI::Model::Todo;
use Mojo::Base -base;

has 'id';
has 'title';
has 'completed' => 0;
has 'created_at';

# In-memory storage
my $todos = {};
my $next_id = 1;

sub new {
  my $class = shift;
  my $self = $class->SUPER::new(@_);
  $self->created_at(time) unless $self->created_at;
  return $self;
}

sub all {
  my $self = shift;
  return [values %$todos];
}

sub find {
  my ($self, $id) = @_;
  return $todos->{$id};
}

sub save {
  my $self = shift;
  $self->id($next_id++) unless $self->id;
  $todos->{$self->id} = $self;
  return $self;
}

sub update {
  my ($self, $id) = @_;
  return unless exists $todos->{$id};
  $self->id($id);
  $todos->{$id} = $self;
  return $self;
}

sub delete {
  my ($self, $id) = @_;
  return delete $todos->{$id};
}

sub to_hash {
  my $self = shift;
  return {
    id => $self->id,
    title => $self->title,
    completed => $self->completed,
    created_at => $self->created_at
  };
}

1;
