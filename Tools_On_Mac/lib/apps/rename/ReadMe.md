以"Git 101(me.org)(szw).txt"为例

1. 支持纯文本
如: replace = "Git", with = "git", 结果就成了"git 101(me.org)(szw).txt"

2. 支持正则
如: replace = "\(.*?\)", with = "", 结果就成了"Git 101.txt"
1). "\(", "\)"是因为括号在正则中有特别意义, 即括成group. 现在我们就要替换括号, 所以要转义
2). ".*"是任意字符. 加上"?"是表示non-greedy.
    要是不加?, 那"(me)abc(szw)"会被替换成""
    要是加了?, 那"(me)abc(szw)"会被替换成"abc"
3). 注意, 输入不用特别再转转义, 即不要replace = "\\(.*?\\)", 这反而不行. replace = "\(.*?\)" 就可以了