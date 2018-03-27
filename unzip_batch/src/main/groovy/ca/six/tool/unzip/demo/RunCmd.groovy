package ca.six.tool.unzip.demo

// this is an example of running WINDOWS cmd
def runCmd(){
//    def process = Runtime.getRuntime().exec("explorer E:/temp") //fail, 会走到"我的文档", 即默认目录里去
    def process = Runtime.getRuntime().exec("explorer E:\\temp")

}

runCmd()