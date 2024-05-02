define-command change-directory-to-buffer %{
    evaluate-commands %sh{
        [ ! -f "${kak_buffile}" ] && exit
        buffer_basename="${kak_bufname##*/}"
        buffer_dirname=$(dirname "${kak_bufname}")
        echo "cd ${buffer_dirname}"
    }
}
