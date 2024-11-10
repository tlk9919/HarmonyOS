class Item{
  name:string
  image:ResourceStr
  price:number
  discount:number
//构造函数
  constructor(name:string,image:ResourceStr,price:number,discount=0) {
    this.name=name
    this.image=image
    this.price=price
    this.discount=discount
  }
}
@Entry
@Component
struct Example {
  //Item的类的数组
 private items:Array<Item>=[
   new Item('华为Mate60',$r('app.media.mate60'),6999,500),
   new Item('小米15',$r('app.media.Xiaomi15'),5999),
   new Item('小米14',$r('app.media.Xiaomi14'),4999),
   new Item('华为Mate60',$r('app.media.mate60'),6999),
   new Item('华为Mate60',$r('app.media.mate60'),6999)
 ]
  build() {
    Column({space:8}) {
      Row() {
        Text('商品列表')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
      .height(30)
      .margin({bottom:20})

      List({ space:8}){//List里面必须要跟ListItem，并且：ListItem之能有一个根组件
        ForEach(
          this.items,
          ( item:Item)=>{
         ListItem(){
           Row({space:10}){
             Image(item.image)
               .width(100)
             Column({space:4}){
               if(item.discount){
                 Text(item.name)
                   .fontSize(20)
                   .fontSize(FontWeight.Bold)
                 Text('原价： ￥'+item.price)
                   .fontColor('#CCC')
                   .fontSize(14)
                   .decoration({type:TextDecorationType.LineThrough})//表示在文本上添加一条贯穿文本的横线（通常称为“删除线”）
                 Text('折扣价： ￥'+(item.price-item.discount))
                   .fontColor('#F36')
                   .fontSize(18)
                 Text('补贴： ￥'+item.discount)
                   .fontColor('#F36')
                   .fontSize(18)
               }
               else {
                 Text(item.name)
                   .fontSize(20)
                   .fontSize(FontWeight.Bold)
                 Text(' ￥'+item.price)
                   .fontColor('#F36')
                   .fontSize(18)
               }

             }
             .height('100%')
             .alignItems(HorizontalAlign.Start)
           }
           .width('100%')
           .backgroundColor('#FFF')
           .borderRadius(20)
           .height(120)
           .padding(10)
         }
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      //可以按照权重比例来分配这些元素的空间。如果没有这个属性，元素会根据内容或默认的布局规则来占据空间。


    }
    .width('100%')
    .height('100%')
    .backgroundColor('#EFEFEF')
    .padding(20)
  }
}