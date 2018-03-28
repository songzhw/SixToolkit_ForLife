
//TODO 用时, 要修改out与dir两个目录!

def out = new File('E:/tmp/move-file-to-top/out')
if(!out.exists()){
    out.mkdir()
}

def list = new ArrayList()
def dir = new File('E:/tmp/move-file-to-top')
dir.eachFileRecurse { File file ->
    if (file.isDirectory()) {
        return
    }

    def name = file.name
    if (!name.endsWith(".txt") && !name.endsWith(".jpg") && !name.endsWith(".png")) {
        return
    }

    list.add(file)
}

// 拿出eachFileRecurse{}的block，是为了连out目录中的文件也move一次
list.forEach{ File file ->
    def srcPath = file.path
    def dstPath = "${out.path}\\${file.name}"
    new AntBuilder().sequential {
        move(file: srcPath, tofile: dstPath)
    }
}
