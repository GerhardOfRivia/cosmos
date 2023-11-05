# Stash API is useful for storing simple key/value pairs
# to preserve state between script runs
stash_set("key1", "val1")
stash_set("key2", "val2")
check_expression(f"'{stash_get('key1')}' == 'val1'")
check_expression(f"'{stash_get('key2')}' == 'val2'")
check_expression(f"{stash_keys()} == ['key1', 'key2']")
stash_set("key1", 1)
stash_set("key2", 2)
check_expression(f"{stash_all()} == {{'key1':1, 'key2':2}}")
stash_delete("key2")
check_expression(f"{stash_get('key2')} == None")
stash_delete("key1")
data = [1, 2, [3, 4]]
stash_set("ary", data)
check_expression(f"{stash_get('ary')} == {data}")
stash_delete("ary")
# Note: hashes with symbol keys works but get converted to string keys on stash_get
hash = {"one": 1, "two": 2, "string": "string"}
stash_set("hash", hash)
check_expression(f"{stash_get('hash')} == {hash}")
stash_delete("hash")
