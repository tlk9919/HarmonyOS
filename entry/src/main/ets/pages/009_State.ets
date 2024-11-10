class Person {
  name: string
  age: number


  constructor(name:string,age:number)
{
  this.name = name
  this.age = age

}
}
@Entry
@Component
//对类的属性进行修改
struct StatePage2 {
  inx : number=1
  @State  p:Person =new Person('Jak',21)
  @State gfs: Person[]=[
    new Person('rose:' ,21),
    new Person('lucy:',20)

  ]
  build() {
    Column() {
      Text(`${this.p.name},${this.p.age }`)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.p.age++
        })
      Button('添加女友')
        .onClick(()=>{
          // gfs 是一个数组，而数组在 JavaScript/TypeScript 中是动态的，可以随时添加新的元素
          this.gfs.push(new Person('女友'+ this.inx++,20))
        })
//嵌套的数据不会被渲染，只是值变了
//       Text(`${this.p.gf.name},${this.p.gf.age }`)
//         .fontSize(50)
//         .fontWeight(FontWeight.Bold)
//         .onClick(() => {
//           this.p.gf.age++
//         });
      Text('==女友列表==')
        .fontSize(50)
      ForEach(
        this.gfs,
        (p:Person,index)=>{
        Row(){
          Text(`${p.name} ${p.age }`)
            .fontSize(30)
            .onClick(() => {
              p.age++//数组的元素是一个对象，对象类的属性变更不会使视图渲染，添加、删除、重新赋值可以
            });
          Button('删除女友')
            .onClick(()=>{
              //array.splice(startIndex, deleteCount);
              // startIndex: 要开始操作的位置（删除的第一个元素的索引）。
              // deleteCount: 要删除的元素个数。
              this.gfs.splice(index,1)
              // array.slice(startIndex, endIndex)
              // startIndex: 起始索引，包含该位置的元素。
              // endIndex: 结束索引，不包括该位置的元素。如果未指定，slice 会提取到数组的末尾。
            })
        }
        .width('100%')
          .justifyContent(FlexAlign.SpaceAround)
        }
      )

    }
    .width('100%')
    .height('100%')
    .padding(20)
  }

}


@Component
struct StatePage {
  @State name: string = 'Mark';//状态变量,@state必须初始化，不能为空值
  @State age: number = 21;

  build() {
    Column() {
      Text(`${this.name},${this.age }`)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.age++;
        });
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center);
  }

}