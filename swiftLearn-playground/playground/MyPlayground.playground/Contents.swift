import UIKit
//
//class Person {
//    var name : String
//    var age : Int
//
//    init(name: String,age: Int) {
//        self.age = age
//        self.name = name
//    }
//}
///// 想要打印person的toString方法
//
//extension Person : CustomStringConvertible {
//    var description: String {
//        get {
//            return "name:\(name) age:\(age)"
//        }
//    }
//}
//
//let zhangsan = Person(name: "zhangsan", age: 2)
//print(zhangsan)//实现了协议CustomStringConvertible，就可以直接打出Person的所有属性了
//
///// 类型的别名,auto就是UInit32的别名
//typealias auto = UInt32
//var smal : auto = 32
//
//// MARK: - 元组Tuple
///** 元组Tuple
// 可以把多个值合并成单一的复合型值
// 元组内的值可以是任何类型，而且可以不必是同一类型
// **/
//let error = (1,"没有权限")
//print(error)
////访问元组里面的元素
//print(error.1)
///// 给msg定义了any类型，msg的值就可以随便设置类型了，不用都是string类型
//var err2:(code:Int,msg:Any) = (code:1,msg:"没有权限")
//err2.code = 2
//err2.msg = 2222
//print(err2)
///// 元组的分解
//let e3 = (1006,"没有权限")
//let (code,msg) = e3//把e3里面的属性分别分解为code和msg
//print(code)
//print(msg)
///// 元组作为函数返回值，可以返回多个参数
//func testFunc() -> (code:Int,msg:String){
//    return (-1,"no permision")
//}
//let e4 = testFunc()
//print(e4.msg)
//
//
//// MARK: - 可选值类型:optional也就是？
///***
// Optional其实是标准库里面的一个enum类型
// public enum Optional<Wrapped> : ExpressibleByNilLiteral {
// case none
// case some(Wrapped)
// }
// */
//var s1 : String? = nil
//var s2 : Optional<String> = "sbc"//和上面的等价
//
//if s2 != nil {
//    let count1 = s2?.count
//    //通过unsafelyUnwrapped来获取实际的包装的值，也就是“？”的原理
//    let count2 = s2.unsafelyUnwrapped.count//和上面等价
//}
//
//// MARK: - 字符串
//let a = """
//  1
//            2
//    3
//  """
//print(a)
//
//
//// MARK: -  值溢出
//var n1 : UInt8 = 255
////var n2 = n1 + 10//定义了UInt8最大只能是256，所以益处了，会报错
//var n2 = n1 &+ 3//定义了UInt8最大只能是256,使用了“&+”，允许益处，255+3=258 > 256,所以从最小开始计算，也就是 255+3=258-256=2
//print(n2)
//
//
//// MARK: - 合并空值类型 “？？”
//print("-----------")
//var l1 :Int? = 1
//var l2 :Int? = 2
//let l3 = (l1 ?? 0) + (l2 ?? 0)
//print(l3)
//
//
//// MARK: - 区间运算
//print("-------区间元算----")
//for i in 1...5 {
//    print(i)
//}
///// 终点运算符，终点是5，起点未知，所以不能遍历range
//let range = ...5
//print(range)
//
///// reversed ,逆序
//for i in (1...5).reversed() {
//    print(i)
//}
//
//print("-----------")
//let numArray = [0,1,2,3,4,5,6]
//for i in numArray[...3] {
//    print(i)
//}
//for i in numArray[..<3] {
//    print(i)
//}
//
/////
//let hello = "hello,World"
//let az = "a"..."z"
//for char in hello {
//    if !az.contains(String(char)) {
//        print("\(char)不是小写字符")
//    }
//}
//
//// MARK: - 位运算
//
/////不借助临时变量交换a、b的值，^是对应位数不同时为1，相同为0
//var changeA = 1//二进制01
//var changeB = 2 //二进制：10
//changeA = changeA ^ changeB//二进制运算结果：11
//changeB = changeA ^ changeB//二进制运算结果：01
//changeA = changeA ^ changeB//二进制运算结果：10
//print("changeA:\(changeA),changeB:\(changeB)")
//
///// 判断一个二进制的数中有多少个1
//func countForOnes(nums:Int)->Int {
//    var count = 0
//    var temp = nums
//    while temp != 0 {
//        count += temp & 1//任何数和00000001做“与”运算，前面的几位都是0，如果末位数为1的话，结果就是1，如果是0，结果就是0
//        temp = temp >> 1//右移一位，挨个判断最后一个位的值是不是1
//    }
//    return count
//}
////上面的升级版，避免有11000000，这样子的话，就浪费了6次那个0的情况了
//func countForOnesUp(nums:Int)->Int {
//    var count = 0
//    var temp = nums
//    while temp != 0 {
//        count += 1
//        temp = temp & (temp - 1)//temp是11000000，temp-1=10111111，temp & (temp - 1) = 100000，消除了第七位的1，然后重复循环就会消去第八位的1，只循环两次就够了，节省算法时间
//    }
//
//    return count
//}
//
/////有一个都是双数的数组，缺少了两个不一样的数字，找出他们，比如【1，2，3，4，4，3】找出来【1，2】
//func findLost(nums:[UInt])->(UInt,UInt) {
//    var lost1 : UInt = 0
//    var lost2 : UInt = 0
//    var temp : UInt = 0
//    for n in nums {
//        temp = temp ^ n//得到两个不一样的数的异或值，也就是1^2
//    }
//    print(temp)
//    // 从左往右找，找到第一个为1的位
//    var flag :UInt = 1
//    print(flag & temp)
//    while (flag & temp) == 0 {
//        flag = flag << 1
//    }
//    print(flag)
//    //找两个丢失的数字
//    for n in nums {
//        if (n & flag) == 0 {
//            lost1 = lost1 ^ n
//        } else {
//            lost2 = lost2 ^ n
//        }
//    }
//
//
//    return(lost1,lost2)
//}
//print(findLost(nums: [1,2,3,4,5,4,1,2]))
//
//// MARK: - 为类和结构体自定义运算符
//print("------------------")
//struct Vector2D {
//    var x = 0.0
//    var y = 0.0
//}
/////给Vector2D自定义“+”运算符
//extension Vector2D {
//    static func + (left:Vector2D,right:Vector2D) -> Vector2D {
//        return Vector2D(x: left.x + left.x, y: left.y + right.y)
//    }
//}
//
/////inout
//extension Vector2D {
//    /// 保持right不变，left是可修改的，left被修改为：left +right的值
//    static func += (left: inout Vector2D, right: Vector2D){
//        left = left + right
//    }
//}
/////一元运算符,定了一个取负数的运算符
//extension Vector2D {
//    static prefix func - (vector:Vector2D) -> Vector2D {
//        return Vector2D(x: -vector.x, y: -vector.y)
//    }
//}
///// equatable协议
//extension Vector2D: Equatable {
//    /// 判断两个对象相等，可以用这种方式来自定义自己觉得相等的对象
//    static func == (left: Vector2D, right: Vector2D) -> Bool {
//        return left.x == right.x && left.y == right.y
//    }
//}
//var vector1 = Vector2D(x: 1, y: 2)
//var vector2 = Vector2D(x: 3, y: 3)
//
//let newVector = Vector2D(x: vector1.x + vector2.x, y: vector1.y + vector2.y)
//let newVector1 = vector1 + vector2//等价于上面的写法，这种写法的好处是，如果上面的算法有多处用到了，并且要修改的话，就需要修改多处，但是这种写法只需要去修改extension 里面的自定义运算就可以了
//let vector3 = -vector2//一元运算符的使用，直接取反
//vector2 += vector1
//print("\(vector2.x),\(vector2.y)")
//
//// MARK: - 自定义运算符 (custom operators),新的运算符要在全局作用域内，使用operator关键字进行声明，同时还要指定prefix（前缀）、infix（中缀）、或者postfix（后缀）限定符
///// 定义“+-”的中间运算符
//infix operator +-: AdditionPrecedence
//extension Vector2D {
//    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
//        return Vector2D(x: left.x + right.x, y: left.y - right.y)
//    }
//}
///// 自定义优先级
//infix operator ++: MyPrecedence
//precedencegroup MyPrecedence {
//    associativity: left
//    lowerThan: AdditionPrecedence //优先级低于AdditionPrecedence的优先级，也就是“+-”会比“++”更早执行
//}
//
//let firVector = Vector2D(x: 2, y: 3)
//let secVector = Vector2D(x: 3, y: 4)
//let plusVector = firVector +- secVector
//
//
//// MARK: - for in循环
/////使用stride(from:to:by:)函数来跳过不想要的标记（开区间），stride(from:through:by:)闭区间
//print("---------for in 循环---------")
//for by in stride(from: 0, to: 10, by: 2) {
//    print(by)
//}
//for through in stride(from: 0, through: 10, by: 2) {
//    print(through)
//}
//
//// MARK: - case
///// swith元组的妙用
//let point = (2,0)
//switch point {
//case (1,1),(2,2):
//    print("复合匹配")
//case (-2...2, -2...1)://匹配第一个数载-2到2之间，第二个数-2到1之前的point
//    print("元组区间匹配")
//case (_,0)://匹配第一个数位任意值，第二个数位0的point
//    print("_代表任意值")
//case (let newName, 0)://值绑定，匹配第一个数位任意值，并且把第一个值赋值给newName，第二个数位0的point
//    print("\(newName)")
//case (let x, let y) where x == y:
//    print("where语句 ，定义了x、y来赋值，并且x=y的时候才会进来")
//case (10,10):
//    print("控制转移：击穿到下一个case，也只能击穿一个case而已：fallthrough")
//    fallthrough
//default:
//    print("啥也没有")
//}
///// 可选类型的循环
//let someInt: [Int?] = [nil,1,2,nil]
//for case let x? in someInt {
//    print(x)
//}
////// 表达式模式
//struct Teacher {
//    var salary: Int
//}
/////重载了“~=”方法，这样子在swith中就不用取出teacher.salary的值作为匹配了，直接用teacher对象作为匹配就行了
//func ~=(pattern: Range<Int>, value: Teacher) -> Bool {
//    return pattern.contains(value.salary)
//}
//let teacher = Teacher(salary: 1000)
//switch teacher {
//case 0..<1000:
//    print("leve 1")
//case 1000..<5000:
//    print("leve 2")
//default:
//    print("leve 3")
//}
// // MARK: - 数组的操作
//var testArray = [1,2,3,4,5]
//testArray.forEach { (i) in
//    if i == 3 {
//        return//只能跳出一次循环，不能结束所有循环， 跟continue类似，但是forEach里面不能使用continue或者break
//    }
//    print("each:\(i)")
//}
///// 可以得到index
//for (index,number) in testArray.enumerated() {
//    print("第\(index)个，值是：\(number )")
//}
///// 如果所有的元素都是大于0的话，返回true，否则false
//print("是否所有的数都是大于0的数\(testArray.allSatisfy({ $0 > 0}))")
//testArray.first(where: { $0 > 1 })//返回大于1的第一个元素
//testArray.removeSubrange(1...2)//移除第1到第2个元素
//testArray.removeAll(keepingCapacity: true)//移除数组中的所有元素，但是保留了数组的容量.
/////随机化
//testArray.shuffle()//把原来数组打乱，也就是testArray的顺序被打乱了
//let newArray = testArray.shuffled()//原来数组不打乱，testArray还是之前的顺序，重新生成了一个打乱的数组返回
/////逆序
//testArray.reverse()//testArray.reversed()
/////  分组,通过限定条件把数组分为两部分，前半部分不符合条件，后半部分符合条件
//let index = testArray.partition { (element) -> Bool in
//    element > 3
//}
//let partition1 = testArray[..<index]//返回不符合条件的数组，也就是<=3的数组切片
//let partition2 = testArray[index...]//返回符合条件的数组，也就是>3的切片
/////  交换
//testArray.swapAt(0, 3)
//testArray.sort()
///// 实现一个队列，先进先出
//struct Queue<T> {
//    private var elements = [T]()
//
//    var isEmpty: Bool {
//        return elements.isEmpty
//    }
//    // 入队
//    mutating func enqueue(_ element: T) {
//        elements.append(element)
//    }
//    // 出队
//    mutating func dequeue() -> T? {
//        return isEmpty ? nil : elements.removeFirst()
//    }
//}

// MARK: - set 集合
/// 求一个集合的所有子集
//func getSubsSetsOfSet<T>(set: Set<T>) -> Array<Set<T>> {
//    let count = 1 << set.count // 等价于2^n，2的n次方
//    let elements = Array(set)
//    var subSets = Array<Set<T>>()
//    print("count:\(count)")
//    for i in 0 ..< count {
//        var subSet = Set<T>()
//        for j in 0 ... elements.count {
//            print("i:\(i),j:\(j),i >>j \(i >> j), &1:  \((i >> j) & 1)")
//            if ((i >> j) & 1) == 1 {
//                subSet.insert(elements[j])
//            }
//        }
//        subSets.append(subSet)
//    }
//    return subSets
//}
//getSubsSetsOfSet(set: [1,2,3])

// MARK: - 字典
//let d1 = Dictionary<String,Int>()
//let d2 = [String: Int]()
//let d3: Dictionary<String,Int> = [:]
/// dictionary本来是无序的，可以使用keyValuePairs来保持顺序
//var dic: [String: Int] =  [:]
//dic.reserveCapacity(3)
//dic.merge(["a":1,
//          "b":2,
//          "c":3,
//          "d":4]) { (_, new) -> Int in
//    return new
//}
//
////使用keyValuePairs来保持顺序
//let dic2: KeyValuePairs =  ["a":1,
//                           "b":2,
//                           "c":3,
//                           "d":4,]
//dic.capacity
//for d in dic {
//    print(d)
//}
///// 定义的形参可以赋值改变他的值
//func sum(sum: inout Int) {
//    sum = 10
//}

//let source = "ello world"
////首字母大写
//print(source.capitalized)

// MARK: - 枚举

/// 使枚举可以被遍历 需要实现:CaseIterable
//enum CompassPosition : Int,CaseIterable {
//    case north
//    case south
//    case east
//    case west
//    // 下标
//    static subscript(index: Int) -> CompassPosition {
//        get {
//            return CompassPosition(rawValue: index)!
//        }
//    }
//}
//for direction in CompassPosition.allCases {
//    print("position:\(direction)")
//}
//print("通过下标来获取：\(CompassPosition[2])")
///// 关联值，定义不同类型的枚举
//enum Barcode {
//    case upc(Int,Int,Int,Int)
//    case qrCode(String)
//}
//var productBarcode = Barcode.upc(8, 8848, 4, 4444)
//let qrBarcode = Barcode.qrCode("www.nihaoa.com")
//
///// 类、结构体、枚举的下标
//struct Matrix {
//    let rows: Int
//    let columns: Int
//    var grid: [Double]
//
//    init(rows: Int, columns: Int) {
//        self.rows = rows
//        self.columns = columns
//        grid = Array(repeating: 0.0, count: rows * columns)
//    }
//
//    subscript(row: Int, column: Int) -> Double {
//        get {
//            return grid[row * columns + column]
//        }
//        set(value) {
//            grid[row * columns + column] = value
//        }
//    }
//}
//
//var matrix = Matrix(rows: 2, columns: 2)
//matrix[1,0] = 9.9
//matrix[0,1] = 8.8
//print(matrix.grid)
//
//// MARK: - 初始化
//class Person {
//    var name: String
//    var age: Int
////    指定的初始化必须要包含所有的存储成员变量，使用便捷初始化（convenience）就可以不用了
////    init() {
////    }
//    init(name:String, age: Int) {
//        self.name = name
//        self.age = age
//    }
//    convenience init(name:String){
//        self.init(name: name, age: 10)
//    }
//    //强制的初始化器required，子类必须要继承
//    required convenience init(age: Int){
//        self.init(name: "nonName", age: age)
//    }
//}
//class Teacher: Person {
//    var salary: Int
//    init(name: String, age: Int, salary: Int) {
//        self.salary = salary
//        super.init(name: name, age: age)
//    }
//    /// 强制的初始化器，父类定义了，所以子类必须要有
//    required convenience init(age: Int) {
//        fatalError("init(age:) has not been implemented")
//    }
//    /// 可空的初始化器
//    convenience init?(salary: Int) {
//        if salary < 200 {
//            return nil
//        }
//        self.init(name:"王老师",age:12,salary: salary)
//    }
//}
//
//// MARK: - extension 和协议protocol
///// 添加内嵌类型，把int分为0、正整数、副整数
//extension Int {
//    enum Kind {
//        case negative,zero,positive
//    }
//    var kind: Kind {
//        switch self {
//        case 0:
//            return .zero
//        case let x where x > 0:
//            return .positive
//        default:
//            return .negative
//        }
//    }
//}
//print("类型：\(3.kind)")

//protocol Named {
//    var name: String {get set}
//}
//protocol Named2 {
//    var age: Int { get set }
//}
///// 可以给协议扩展添加限制
//extension Collection where Iterator.Element: Named {
//    var name: String {
//        let names = self.map{ $0.name + "prefix" }
//        return names.joined(separator: "#")
//    }
//}
//struct XXX:Named {
//    var name: String
//
//}
//let array = [XXX( name: "zhangshan"),XXX( name: "王武")]
//print(array.name)
//
///// 协议自己实现协议
//protocol ValidatesUserName {
//    func isUsernameValid(userName: String) -> Bool
//}
//extension ValidatesUserName {
//    func isUsernameValid(userName: String) -> Bool {
//        if userName.count <= 0 {
//            return false
//        } else if userName.count >= 18 {
//            return false
//        }
//        return true
//    }
//}
//struct User: ValidatesUserName {//实现了协议ValidatesUserName，ValidatesUserName里面也有实现，相当于继承了isUsernameValid的方法
//    func checkUserName(userName: String) -> Bool {
//        return isUsernameValid(userName: userName)
//    }
//}

// MARK: - 错误
//enum MySelfError: Error {
//    case translateError
//}
//func translateString2Int(numberString: String) throws -> Int {
//    guard let number = Int(numberString) else {
//        throw MySelfError.translateError
//    }
//    return number
//}
//let x = try? translateString2Int(numberString: "f")
//print("x value is \(x)")


class Person: NSObject {
    let name: String
    var apart: Apart?
    
    init(name: String) {
        self.name = name
        print("\(name)is being init")
    }
    
    deinit {
        print("\(name) is being deinit")
    }
}
class Apart {
    let name: String
    weak var person: Person?
    init(name: String) {
        self.name = name
        print("\(name)is being init")
    }
    
    deinit {
        print("\(name) is being deinit")
    }
}

var p: Person? = Person(name: "jone")
var a: Apart? = Apart(name: "part 3")
//p!.apart = a
a!.person = p
a = nil
//p = nil
print("p name:\(p?.apart?.name)")


let aas = "asdfss"
let cset = aas.rangeOfCharacter(from: CharacterSet.alphanumerics)
print(aas)
print(cset)
//if let newSet = cset {
//    for s in newSet {
//        print("自己的字符：\(s)")
//    }
//
//}
//print(aas.rangeOfCharacter(from: CharacterSet.alphanumerics))
