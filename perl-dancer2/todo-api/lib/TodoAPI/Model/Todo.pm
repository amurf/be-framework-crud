package TodoAPI::Model::Todo;
use strict;
use warnings;
use Time::HiRes qw(time);

# In-memory storage
my $todos = {};
my $next_id = 1;

# Constructor
sub new {
    my ($class, %args) = @_;
    my $self = bless {
        id => undef,
        title => $args{title},
        completed => $args{completed} // 0,
        created_at => time(),
    }, $class;
    return $self;
}

# Accessors
sub id { $_[0]->{id} }
sub title { $_[0]->{title} = $_[1] if @_ > 1; $_[0]->{title} }
sub completed { $_[0]->{completed} = $_[1] if @_ > 1; $_[0]->{completed} }
sub created_at { $_[0]->{created_at} }

# Class methods
sub all {
    return values %$todos;
}

sub find {
    my ($class, $id) = @_;
    return $todos->{$id};
}

# Instance methods
sub save {
    my $self = shift;
    $self->{id} = $next_id++ unless defined $self->{id};
    $todos->{$self->{id}} = $self;
    return $self;
}

sub update {
    my ($self, $id) = @_;
    return unless exists $todos->{$id};
    $self->{id} = $id;
    $todos->{$id} = $self;
    return $self;
}

sub delete {
    my ($class, $id) = @_;
    delete $todos->{$id};
}

sub to_hash {
    my $self = shift;
    return {
        id => $self->id,
        title => $self->title,
        completed => $self->completed,
        created_at => $self->created_at,
    };
}

1;
