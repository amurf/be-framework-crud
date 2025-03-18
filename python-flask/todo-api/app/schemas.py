from marshmallow import Schema, fields, validate

class TodoSchema(Schema):
    id = fields.Int(dump_only=True)
    title = fields.Str(required=True, validate=validate.Length(min=1))
    completed = fields.Bool(missing=False)
    created_at = fields.Float(dump_only=True)

todo_schema = TodoSchema()
todos_schema = TodoSchema(many=True)
