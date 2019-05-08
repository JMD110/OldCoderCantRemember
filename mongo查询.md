### 查询值长度 

.find({item_name:{$exists:true},$where:"(this.item_name.length > 25)"}).limit(5)

### 组合查询
.aggregate({'$group': {'_id': '$item', 'num_count': {'$sum': 1}}}, {'$sort': {'num_count': -1}})
.aggregate([{$match: {"query_type":"","item":{"$ne":""}}},{$project: {"item":true}}, {$group: {_id:"$item"}}])
.aggregate([{$match: {"query_type":"","item":{"$ne":""}}},{$project: {"search_string":true}}, 
{$group: {_id:"", 'num_count': {'$sum': 1}}},{'$sort': {'num_count': -1}}])

### 正则查询
.find({post_text:{$regex:"runoob",$options:"$i"}})
.find({key:{$regex: /^(?!([(exp)|(exp1)])).*$/}})

### 值大小
.find({likes : {$gt : 100}})

### 值不等于
.find({"":""}).where("").ne("")


### 批量更新
.update(
{'id':{$in:[1,2,3,10,12,13]}}, //query
{$set:{'contract_status': NumberInt(1)}},// update 
{multi:true,upsert:false} // 批量更新
)


.aggregate([
  // Group on unique value storing _id values to array and count 
  { "$group": {
    "_id": { : "$"},
    "ids": { "$push": "$_id" },
    "count": { "$sum": 1 }      
  }},
  // Only return things that matched more than once. i.e a duplicate
  { "$match": { "count": { "$gt": 1 } } }
], { allowDiskUse: true } )

### 字符长度排序

.aggregate([{
    $project: {
        name:"$name",
         byteLength: {$strLenBytes: "$name"}
    }
}]).sort({byteLength:-1})
