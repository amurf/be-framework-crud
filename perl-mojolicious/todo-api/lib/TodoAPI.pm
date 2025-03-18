package TodoAPI;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Load configuration from config file
  my $config = $self->plugin('NotYAMLConfig');

  # Configure the application
  $self->secrets($config->{secrets});

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('example#welcome');

  # API routes
  my $api = $r->under('/api');
  $api->get('/todos')->to('todos#index');
  $api->get('/todos/:id')->to('todos#show');
  $api->post('/todos')->to('todos#create');
  $api->put('/todos/:id')->to('todos#update');
  $api->delete('/todos/:id')->to('todos#delete');
}

1;
