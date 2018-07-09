task 'create_tasks' => sub {
  create_table "tasks" => sub {
    string "title"
    string "content"

    # add created_at and updated_at columns
    add_timestamps(nullable: 0); 
  }
};
