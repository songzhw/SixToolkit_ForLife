package ca.six.tool.unzip

def unzip(File src) {
    src.eachDir { dict ->
        // def dictName = dict.getAbsolutePath()
        dict.eachFileRecurse { file ->
            if (file.isDirectory()) {
                return
            }

            def name = file.name
            if (!name.endsWith("7z") && !name.endsWith("zip")) {
                return
            }

            unzipTo(file, dict)
        }
    }
}

def unzipTo(File zip, File dest) {
    println "\t ${zip.getAbsolutePath()}  || ${dest.getAbsolutePath()}"
    Runtime.getRuntime().exec("7z x \"${zip.getAbsolutePath()}\" -o\"${dest.getAbsolutePath()}\"")
}

unzip(new File("F:\\axDown_44G\\Third"))

/*
    src.eachDir { dict ->
        println(dict)
    }
只会打出第一级的子目录, 不会打出孙目录, 重孙目录, ...
 */