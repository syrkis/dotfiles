function beam
    set file_extension ( string split -r -m 1 '.' $argv[1] )[-1]
    set random_name (uuidgen)
    set remote_file_name $random_name"."$file_extension
    s3cmd put $argv[1] "s3://syrkis/files-bucket/$remote_file_name" --acl-public
    echo -n "https://syrkis.ams3.digitaloceanspaces.com/files-bucket/$remote_file_name" | pbcopy
end
