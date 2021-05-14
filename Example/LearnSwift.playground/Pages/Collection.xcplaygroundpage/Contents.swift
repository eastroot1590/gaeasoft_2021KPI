
var array: [Int] = [1, 2, 3, 4, 5]
var array2 = [1, 2, 3, 4, 5]

var trees = ["Pine", "Oak", "Yew"]
print(trees[2])  // Yew
print(trees.count)  // 3
if trees.isEmpty {
    print("empty")
}

let shuffled = trees.shuffled()
let randomTree = trees.randomElement()

trees += ["Redwood"]
trees.append(contentsOf: ["Maple", "Birch"])

var dic: [String: Int] = ["gaea": 5, "oasis": 10]
var dic2 = ["gaea": 5, "oasis": 10]

print(dic["gaea"])  // Optional(5)
dic["gaea"] = 20
print(dic["gaea"])  // Optional(20)
dic.updateValue(30, forKey: "oasis")
print(dic["oasis"])  // Optional(30)


dic["gaea"] = nil
dic.removeValue(forKey: "oasis")
