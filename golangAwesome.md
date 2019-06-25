# 从前我最喜换Python 现在我脚踏两条船了
## Go语言主要特性
- 自动垃圾回收(Python: so easy?)
- 丰富内置类型(Python: I don't think so)
- 函数多返回值(Python: I can)
- 错误处理(Python:are you sure?)
- 匿名函数和闭包(Python: give me something new?)
- 类型和接口(Python: Not bad!)
- 并发编程(Python: Yes, double click & 666)
- 反射(I do not use and I do not know)
- 语言交互性(Python: Now, I just found I like you)

## Let's say "Hello World!"
```
package main
// you konw "one line comment"
import "fmt"
/* More
Line
Comment
*/
func main(){
  fmt.Printf("Hello World!")
}
```

## How to download
- Just google or baidu, I dont care. You all need just kown what's gopath
- I'm using vscode, perfect for me to code

## 声明个变量
- var v int = 666 
- v := 666
- var v = 666
- var v1 [3]int {6,6,6}
- var v2 []int {6,6,6}
- 匿名变量 _
- i, j = j, i

## 类型
- bool
- int8/byte/int16/int/uint
- float32/float64
- complex64/complex128(How to use?)
- string
- rune
- error
- 指针(pointer)
- 数组(array)
- 切片(slice)
- 字典(map)
- 通道(chan)
- 结构体(struct)
- 接口(interface)

## 遍历元素
```
package main
import "fmt"

func main(){
  a = [3]int{6,6,6}

  for i :=0; i<len(a); i++ {
      fmt.Println(a[i])
  }

  for _, i := range a {
      fmt.Println(i)
  }
}
```
## make
```
package main
import "fmt"
func main() {
  //cap = 10 5个元素默认为0 {0,0,0,0,0}
  myslice := make([]int, 5, 10)

}
```
