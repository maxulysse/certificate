// Process to convert SVG to PDF
process INKSCAPE {
    tag "${meta.id}"
    container 'docker.io/linuxserver/inkscape:1.4-r0-ls36'

    input:
    tuple val(meta), path(svg)

    output:
    tuple val(meta), path("${meta.id}.pdf"), emit: pdf
    tuple val("${task.process}"), val('inkscape'), eval('inkscape --version | sed "s/.*Inkscape \\([0-9]\\+\\.[0-9]\\+\\(\\.[0-9]\\+\\)\\?\\).*/\\1/"'), topic: versions

    script:
    """
    inkscape ${svg} --export-filename=${meta.id}.pdf
    """
}
