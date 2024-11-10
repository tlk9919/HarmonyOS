import { router } from "@kit.ArkUI"

//自定义组件
@Component
export struct Header{

  private title :ResourceStr=''
  build() {
    Row() {
      Image($r('app.media.back'))
        .width(30)
        .onClick(()=>{
          //返回前弹窗
          router.showAlertBeforeBackPage({
            message:'别推退出啊，求你了'
          })
          //返回上一页
          router.back()

        })
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      Blank()
      //Blank() 可以占据一定的空间，但本身不会渲染任何内容。它经常被用于在容器中“撑开”布局，
      Image($r('app.media.refresh'))
        .width(30)
    }
    .width('100%')
    .height(30)
  }
}
