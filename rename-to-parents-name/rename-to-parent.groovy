def dir = new File('E:/tmp/tmp')
dir.eachFileRecurse { File file ->
    if (file.isDirectory()) {
        return
    }

    def name = file.name
    if (!name.endsWith(".txt") && !name.endsWith(".jpg") && !name.endsWith(".png")) {
        return
    }

    file.renameTo("${file.parent}\\${file.parentFile.name}_$name")

}