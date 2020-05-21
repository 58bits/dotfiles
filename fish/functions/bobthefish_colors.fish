function bobthefish_colors -S -d 'Define a custom bobthefish color scheme'

  # Optionally include a base color scheme
  __bobthefish_colors default

  # Then override everything you want!
  # Note that these must be defined with `set -x`

  set -x color_repo                     d7d787 black
  set -x color_repo_work_tree           black black --bold
  set -x color_repo_dirty               brred black
  set -x color_repo_staged              yellow black

end
