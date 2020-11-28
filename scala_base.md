### 教程地址:
(twitter)[http://twitter.github.io/scala_school/zh_cn/index.html]
(runoob)[https://www.runoob.com/scala/scala-tutorial.html]
### Scala 基本语法
- 区分大小写(大小写敏感)
- 类名(大驼峰 class MyFirstScala)
- 方法名称(小驼峰 def myFirstMethod)
- 程序文件名(.scala)
- 注释
```
object HelloWorld{
    /* 多行
    * 注释
    */
    def main(args: Array[String]){
        // 单行注释
    }
}
```
- 换行符 (;)末尾分号是可选的,一行多语句需要,一行一条语句可不写
` val s = "Hi"; println(s)`
- scala 包
```
// 定义包 方法一
package test
class HelloWorld
// 定义包 方法二
package test{
    class HelloWorld
}
// 引用包
import java.awt.{Color, Font}
// 重命名
import java.util.{HashMap => JavaHashMap}
// 隐藏成员(HashMap)
import java.util.{HashMap => _, _}
```
### scala数据类型
- Byte
- Short
- Int
- Long
- Float
- Double
- Char
- String
- Boolean
- Unit
- Null
- Nothing (任何其他类型的子类型)
- Any (所有其他类的超类)
- AnyRef (Scala所有引用类的基类)

