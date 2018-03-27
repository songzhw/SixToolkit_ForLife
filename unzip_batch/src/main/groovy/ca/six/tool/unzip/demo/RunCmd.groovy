package ca.six.tool.unzip.demo

// this is an example of running WINDOWS cmd
def runCmd() {
//    def process = Runtime.getRuntime().exec("explorer E:/temp") //fail, 会走到"我的文档", 即默认目录里去

    Runtime.getRuntime().exec("explorer E:\\temp")

    getResultFromCmd("7z x E:\\temp\\tmp.7z -oE:\\temp")
}

def getResultFromCmd(cmd){
    def process = Runtime.getRuntime().exec(cmd)
    InputStream input = process.getInputStream();
    BufferedReader reader = new BufferedReader(new InputStreamReader(input));
    String szline;
    while (szline = reader.readLine()!= null) {
        System.out.println(szline);
    }
    reader.close();
    process.waitFor();
    process.destroy();
}


runCmd()