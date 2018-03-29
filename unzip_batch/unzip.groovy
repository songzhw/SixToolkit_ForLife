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

//TODO 入口在这. 修改srcFile的路径即可运行此脚本 
unzip(new File("F:\\a\\tmp"))
