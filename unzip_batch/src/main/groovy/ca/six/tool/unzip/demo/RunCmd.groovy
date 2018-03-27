package ca.six.tool.unzip.demo

// this is an example of running WINDOWS cmd
def runCmd() {
//    def process = Runtime.getRuntime().exec("explorer E:/temp") //fail, 会走到"我的文档", 即默认目录里去

    Runtime.getRuntime().exec("explorer E:\\temp")

    /*
    // windows中, "cd"等于linux中的"pwd", 是打印当前目录
    getResultFromCmd("cd")
    // 但在windows上运行出错了, 说java.io.IOException: Cannot run program "cd": CreateProcess error=2, The system cannot find the file specified
    // 原因见 https://stackoverflow.com/questions/23664789/runtime-exec-not-running-cd
    */

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