package ca.six.tool.unzip

def unzip(File src){
    src.eachDirRecurse { dict ->
        println(dict)
    }
}

unzip(new File("E:\\temp"))

/*
    src.eachDir { dict ->
        println(dict)
    }
只会打出第一级的子目录, 不会打出孙目录, 重孙目录, ...
 */