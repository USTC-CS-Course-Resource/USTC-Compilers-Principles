void main() {
    int i = 0;
    if (i==0) {  // if 中包含循环
        while(1) {  // 循环中包含 if
            if (i == 5) break;  // break
            else {
                for (; i < 5; i++) // for 循环
                    continue;  // continue
            }
        }
    }
}