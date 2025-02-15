## template: jinja
#cloud-config
merge_how:
  - name: list
    settings: [append]
  - name: dict
    settings: [no_replace, recurse_list]

write_files:
  - path: ${path}
    encoding: base64
    permissions: ${permissions}
    content: ${content}
