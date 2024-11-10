import {Header} from  '../components/CommonComponets'
//全局自定义函数
// @Builder function ItemCard(item:Item){
//   Row({space:10}){
//     Image(item.image)
//       .width(100)
//     Column({space:4}){
//       if(item.discount){
//         Text(item.name)
//           .fontSize(20)
//           .fontSize(FontWeight.Bold)
//         Text('原价： ￥'+item.price)
//           .fontColor('#CCC')
//           .fontSize(14)
//           .decoration({type:TextDecorationType.LineThrough})//表示在文本上添加一条贯穿文本的横线（通常称为“删除线”）
//         Text('折扣价： ￥'+(item.price-item.discount))
//           .fontColor('#F36')
//           .fontSize(18)
//         Text('补贴： ￥'+item.discount)
//           .fontColor('#F36')
//           .fontSize(18)
//       }
//       else {
//         Text(item.name)
//           .fontSize(20)
//           .fontSize(FontWeight.Bold)
//         Text(' ￥'+item.price)
//           .fontColor('#F36')
//           .fontSize(18)
//       }
//
//     }
//     .height('100%')
//     .alignItems(HorizontalAlign.Start)
//   }
//   .width('100%')
//   .backgroundColor('#FFF')
//   .borderRadius(20)
//   .height(120)
//   .padding(10)
// }


//全局公共样式 只能写公共的不能写.fontColor('#F36')  .fontSize(18)
// @Styles function  fillscreen(){
//   .width('100%')
//     .height('100%')
//     .backgroundColor('#EFEFEF')
//     .padding(20)
// }

//继承模式，只能写在全局
@Extend(Text) function priceText(){
  .fontColor('#F36')
  .fontSize(18)
}
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
//自定义组件

@Entry
@Component
struct Example {
  //Item的类的数组
 private items:Array<Item>=[
   new Item('华为Mate60',$r('app.media.mate60'),6999,500),
   new Item('小米15',$r('app.media.Xiaomi15'),5999),
   new Item('小米手环9',$r('app.media.watch'),299),
   new Item('Freebuds3 Pro',$r('app.media.freebuds3'),599),
   new Item('MateBookPro X',$r('app.media.notebook'),13999)
 ]

  //局部公共样式
  @Styles   fillscreen(){
  .width('100%')
  .height('100%')
  .backgroundColor('#EFEFEF')
  .padding(20)
}
  build() {
    Column({space:8}) {
      //标题部分
    Header({title:'商品列表'})
      .margin({bottom:20})
      .backgroundColor('#FdF')
      //商品部分
      List({ space:8}){//List里面必须要跟ListItem，并且：ListItem之能有一个根组件
        ForEach(
          this.items,
          ( item:Item)=>{
         ListItem(){
       this.ItemCard(item)
         }
          }
        )
      }
      .width('100%')
      .layoutWeight(1)
      //可以按照权重比例来分配这些元素的空间。如果没有这个属性，元素会根据内容或默认的布局规则来占据空间
    }
    .fillscreen()
  }
  //局部自定义构造函数不加function
  @Builder  ItemCard(item:Item){
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
            .priceText()
          Text('补贴： ￥'+item.discount)
            .priceText()
        }
        else {
          Text(item.name)
            .fontSize(20)
            .fontSize(FontWeight.Bold)
          Text(' ￥'+item.price)
            .priceText()
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