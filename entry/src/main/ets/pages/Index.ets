import { router } from '@kit.ArkUI'

class RouterInfo{
  //页面路径
  url:string
  //页面标题
  title:string

  constructor( url:string,title:string) {
    this.url=url
    this.title=title
  }
}


@Entry
@Component
struct Index {
  @State message:string ='页面列表'
  private routers:RouterInfo[]=[
    new RouterInfo('pages/005_Column', '图片查看案例'),
    new RouterInfo('pages/008_Custom Components', '商品列表案例'),
    new RouterInfo('pages/009_State', 'Jack和他的女友案例'),
    new RouterInfo('pages/012_Observed', '任务列表案例'),
    new RouterInfo('pages/017_DocumentListPage', '任务列表案例'),
    new RouterInfo('pages/018_TaskManagePage', '任务数据库')

  ]
  build() {
    Column(){
      Text(this.message)
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .height(80)
      List({space:8}){
        ForEach(
          this.routers,
          (router:RouterInfo,index)=>{
            ListItem(){
              this.RouterItem(router,index+1)
            }
          }
        )
      }
      .layoutWeight(1)
      .alignListItem(ListItemAlign.Center)//ListItemAlign 是用于列表项对齐的属性
    }
    
  }
  @Builder
  RouterItem( r:RouterInfo,i:number){//i为角标
    Row(){
      Text(i+'.')
        .fontSize(20)
        .fontColor(Color.White)
      Blank()
      Text(r.title)
        .fontSize(20)
        .fontColor(Color.White)
    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({
      radius: 6,
      color: '#4F000000',
      offsetX: 2,  // X 轴偏移量
      offsetY: 2   // Y 轴偏移量
    })
    .onClick(()=>{
      //router跳转
      router.pushUrl(
        {
        url:r.url,
         params:{id:i}
      },
      //跳转模式
        router.RouterMode.Single,
        //失败的回调
        err=>{
          if (err) {
            console.log(`路由失败 errCode:${err.code} ,errMsg:${err.message}`)
          }
        }
      )
    })

  }
}
