# 测试样例

## 第一关

1. input:`a>b<c=d>=e<=f<>g>`
output:`(other,1)(relop,>)(other,1)(relop,<)(other,1)(relop,=)(other,1)(relop,>=)(other,1)(relop,<=)(other,1)(relop,<>)(other,1)(relop,>)`

2. input: `<>>=<>>>=`
output: `(relop,<>)(relop,>=)(relop,<>)(relop,>)(relop,>=)`

3. input: `if (a<=b) a=b`
output: `(other,5)(relop,<=)(other,4)(relop,=)(other,1)`

## 第二关

1. input:`if (a>=b) a=b`
output:`(other,5)(relop,>=)(other,4)(relop,=)(other,1)`

## 第三关

1. input:`if(a==b) a>b `
output:`(other,4)(relop,=)(relop,=)(other,4)(relop,>)(other,1)`
2. input:`< =b `
output:`(relop,<)(other,1)(relop,=)(other,1)`

