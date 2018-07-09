task 'create_comments' => sub {
  create_table "comments" => sub {
    string "content"
    integer "task_id"

    # add created_at and updated_at columns
    add_timestamps(nullable: 0); 
  }
};
