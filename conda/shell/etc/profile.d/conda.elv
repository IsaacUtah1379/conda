use path

# Get the environment indicator (if any)
fn conda_prompt {
    if (has-env CONDA_PREFIX) {
        var env-name = (path:base $E:CONDA_PREFIX)
        put '('$E:CONDA_PREFIX') '
    } else {
        put ''
    }
}

# Update prompt to include environment indicator
var prev_prompt = $edit:prompt
set edit:prompt = { $conda_prompt; $prev_prompt }
