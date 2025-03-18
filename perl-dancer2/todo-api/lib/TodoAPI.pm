package TodoAPI;
use Dancer2;
use JSON;
use TodoAPI::Model::Todo;

# Configuration
set serializer => 'JSON';
set port => 8080;

# Middleware to parse JSON request body
hook 'before' => sub {
    if (request->is_post || request->is_put) {
        my $content_type = request->header('Content-Type') // '';
        if ($content_type =~ m{application/json}i) {
            my $data = from_json(request->body);
            var(json_data => $data);
        }
    }
};

# Routes
get '/api/todos' => sub {
    my @todos = TodoAPI::Model::Todo->all;
    return { data => [map { $_->to_hash } @todos] };
};

get '/api/todos/:id' => sub {
    my $id = route_parameters->get('id');
    my $todo = TodoAPI::Model::Todo->find($id);

    if (!$todo) {
        status 404;
        return { error => 'Todo not found' };
    }

    return { data => $todo->to_hash };
};

post '/api/todos' => sub {
    my $data = vars->{json_data};

    if (!$data->{title}) {
        status 400;
        return { error => 'Title is required' };
    }

    my $todo = TodoAPI::Model::Todo->new(
        title => $data->{title},
        completed => $data->{completed} // 0
    );

    $todo->save;

    status 201;
    header 'Location' => "/api/todos/" . $todo->id;
    return { data => $todo->to_hash };
};

put '/api/todos/:id' => sub {
    my $id = route_parameters->get('id');
    my $data = vars->{json_data};

    my $todo = TodoAPI::Model::Todo->find($id);
    if (!$todo) {
        status 404;
        return { error => 'Todo not found' };
    }

    $todo->title($data->{title}) if exists $data->{title};
    $todo->completed($data->{completed}) if exists $data->{completed};

    $todo->update($id);

    return { data => $todo->to_hash };
};

del '/api/todos/:id' => sub {
    my $id = route_parameters->get('id');

    my $todo = TodoAPI::Model::Todo->find($id);
    if (!$todo) {
        status 404;
        return { error => 'Todo not found' };
    }

    TodoAPI::Model::Todo->delete($id);
    status 204;
    return;
};

1;
