ElasticSearch

 ## 复合聚合
 ### 由于想要实现在es中的group_by, 首先考虑了es中的terms aggregation 
example(同意于group by brand):
```
GET /_search
{
    "aggs" : {
        "group_by" : {  # group_by 名字可自定义
            "terms" : { "field" : "brand" }
        }
    }
}
```
但由于我们的桶类过多 而terms aggregation 默认只返回10个
官方文档:If you want to retrieve all terms or all combinations of terms in a nested terms aggregation you should use the Composite aggregation which allows to paginate over all possible terms rather than setting a size greater than the cardinality of the field in the terms aggregation. The terms aggregation is meant to return the top terms and does not allow pagination.
翻译:如果您想要检索一个嵌套术语聚合中的所有术语或所有术语的组合，那么您应该使用复合聚合，它允许在所有可能的术语上分页，而不是设置大于术语聚合中字段的基数的大小。术语聚合意味着返回顶级术语，并且不允许分页。

修改为复合聚合:
```
GET /_search
"aggs":{
          "group_by": { # group_by 名字可自定义
            "composite" : {
              "size":max_brand_size, # 因为我们需要所有的 size就必须大于或等于你的brand种类 默认同样返回10个
                "sources" : [
                    { "brand": { "terms" : { "field": "brand" } } }
```
