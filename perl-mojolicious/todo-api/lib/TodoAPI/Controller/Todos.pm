package TodoAPI::Controller::Todos;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;
  my $todos = $self->app->todo_model->all;
  $self->render(json => { data => [map { $_->to_hash } @$todos] });
}

sub show {
  my $self = shift;
  my $id = $self->param('id');
  my $todo = $self->app->todo_model->find($id);

  if (!$todo) {
    return $self->render(
      status => 404,
      json => { error => 'Todo not found' }
    );
  }

  $self->render(json => { data => $todo->to_hash });
}

sub create {
  my $self = shift;
  my $data = $self->req->json;

  if (!$data->{title}) {
    return $self->render(
      status => 400,
      json => { error => 'Title is required' }
    );
  }

  my $todo = TodoAPI::Model::Todo->new(
    title => $data->{title},
    completed => $data->{completed} // 0
  );

  $todo->save;

  $self->res->headers->location($self->url_for('todos#show', id => $todo->id));
  $self->render(
    status => 201,
    json => { data => $todo->to_hash }
  );
}

sub update {
  my $self = shift;
  my $id = $self->param('id');
  my $data = $self->req->json;

  my $todo = $self->app->todo_model->find($id);
  if (!$todo) {
    return $self->render(
      status => 404,
      json => { error => 'Todo not found' }
    );
  }

  $todo->title($data->{title}) if exists $data->{title};
  $todo->completed($data->{completed}) if exists $data->{completed};

  $todo->update($id);

  $self->render(json => { data => $todo->to_hash });
}

sub delete {
  my $self = shift;
  my $id = $self->param('id');

  my $todo = $self->app->todo_model->find($id);
  if (!$todo) {
    return $self->render(
      status => 404,
      json => { error => 'Todo not found' }
    );
  }

  $self->app->todo_model->delete($id);
  $self->rendered(204);
}

1;
