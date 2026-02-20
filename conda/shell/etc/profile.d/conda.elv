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

# The conda function
fn conda {|@args|
    if (> (count $args) 0) {
        var cmd = $args[0]
        var extra_args = []

        if (>= (count $args) 2) {
            set extra_args = $args[1..]
        }

        if (has-value [activate deactivate] $cmd) {
            eval ($E:CONDA_EXE shell.elvish $cmd $extra_args)
        } elif (has-value [install update upgrade remove uninstall] $cmd) {
            $E:CONDA_EXE $cmd $extra_args
            eval ($E:CONDA_EXE shell.elvish reactivate)
        } else {
            $E:CONDA_EXE $cmd $extra_args
        }
    } else {
        $E:CONDA_EXE
    }
}
