json.id asset.id
json.project_id asset.project ? asset.project.id : nil
json.user_id asset.user ? asset.user.id : nil
json.name asset.uploaded_file_name
json.uploaded_file_size asset.uploaded_file_size
json.uploaded_content_type asset.uploaded_content_type
json.url asset.uploaded.url
json.created_at asset.created_at
json.parent_id asset.parent ? asset.parent.id : nil
json.version asset.version