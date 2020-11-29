#include <iostream>
#include <list>
#include <string>
#include <cassert>

class Value {
public:
    Value() {
        setName("Value");
    }
    virtual ~Value() {}
    void setName(std::string n) {
        name = n;
    }
    std::string getName() {
        return name;
    }
    virtual void print() {
        std::cout << "I'm a " << getName() << std::endl;
    }
    std::string getType() { // 新加的
        return type;
    }
protected:
    std::string name;
    std::string type; // 新加的
};

class Instruction : public Value {
public:
    Instruction() {
        setName("Instruction");
        type = "Instruction";
    }
    virtual void print() override {
        std::cout << getName() << std::endl;
    }
};

class UnaryInst : public Instruction {
public:
    UnaryInst() {
        setName("UnaryInst");
        type = "UnaryInst";
    }
};

class BinaryInst : public Instruction {
public:
    BinaryInst() {
        setName("BinaryInst");
        type = "BinaryInst";
    }
};

class BasicBlock : public Value {
public:
    BasicBlock() {
        setName("BasicBlock");
        type = "BasicBlock";
    }
    ~BasicBlock() {
        for (auto v : values) {
            delete v;
        }
    }
    virtual void print() override {
        int unary_cnt = 0, binary_cnt = 0;
        for (auto v : values) {
            // 修改处: 用 `getType()` 返回的 `type` 辨识.
            if (v->getType() == "UnaryInst") {
                unary_cnt++;
            }
            // 修改处: 用 `getType()` 返回的 `type` 辨识.
            else if (v->getType() == "BinaryInst") {
                binary_cnt++;
            }
            else {
                std::cerr << "Unspported instruction: " << v->getName() << std::endl;
                abort();
            }
        }
        std::cout << name << ": " << unary_cnt << " unary instructions, " 
            << binary_cnt << " binary instructions" << std::endl;
        for (auto v : values) {
            std::cout << "  " << v->getName() << std::endl;
        }
    }
    void addValue(Value *v) {
        values.push_back(v);
    }
private:
    std::list<Value *> values;
};

int main()
{
    BasicBlock *bb = new BasicBlock();
    bb->addValue(new UnaryInst());
    bb->addValue(new UnaryInst());
    bb->addValue(new BinaryInst());
    bb->addValue(new UnaryInst());
    bb->addValue(new BinaryInst());
    bb->print();
    delete bb;
    return 0;
}