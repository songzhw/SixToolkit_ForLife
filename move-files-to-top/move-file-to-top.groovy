
def out = new File('E:/tmp/move-file-to-top/out')
if(!out.exists()){
    out.mkdir()
}

def dir = new File('E:/tmp/move-file-to-top')
dir.eachFileRecurse { File file ->
    if (file.isDirectory()) {
        return
    }

    def name = file.name
    if (!name.endsWith(".txt") && !name.endsWith(".jpg") && !name.endsWith(".png")) {
        return
    }

    def srcPath = file.path
    def dstPath = "${out.path}\\${file.name}"
    new AntBuilder().copy(file: srcPath, tofile: dstPath)

}