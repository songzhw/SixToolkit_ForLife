def out = new File("result.srt")
def file = new File("script.srt")
def lineSeparator = System.getProperty("line.separator");

def sb = new StringBuilder()
file.eachLine { String line ->
	if(isEligible(line)){
		sb.append(line);
		sb.append(lineSeparator)
	}
}
// println sb.toString()

if(!out.exists()){
	out.createNewFile()
}
// 因为字幕里有中文， 不带这个utf-8， 打开来就是乱码
out.withWriter("UTF-8") { writer->
	writer.write(sb.toString())
}

def isEligible(line){
	if(line.length() == 0) {
		return false
	}

	if(line.startsWith("0") || line.startsWith("1") || line.startsWith("2") 
		|| line.startsWith("3") || line.startsWith("4") || line.startsWith("5")
		|| line.startsWith("6") || line.startsWith("7") || line.startsWith("8") 
		|| line.startsWith("9")){
		return false
	}

	if(line.length() > 0){ //因为有些是以"- "开头的
		def chars = line.toCharArray()
        for (int i = 0; i < chars.length; i++) {  
            if ((chars[i] >= 0x4e00) && (chars[i] <= 0x9fbb)) {  
                return false;  
            }  
        }  
	}

	return true
}


