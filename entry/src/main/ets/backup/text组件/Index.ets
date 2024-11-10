// Index.ets
import { router, Router} from '@kit.ArkUI';
import { BusinessError } from '@kit.BasicServicesKit';

@Entry  // 标记该组件为入口组件
@Component  // 指定这是一个组件
struct Index {  // 定义一个名为 Index 的结构体
  @State message: string = 'Hello World'  // 定义状态变量 message，初始值为 'Hello World'

  build() {  // 构建组件的函数，用于定义组件的 UI 结构。
    Row() {  // 创建一个行布局
      Column() { // 在行中创建一个列布局
        Text(this.message)// 使用状态变量 message 显示文本
          .fontSize(50)// 设置文本的字体大小为 50
          .fontWeight(FontWeight.Bold) // 设置文本为粗体
          .fontColor('#36D')
          .onClick(()=>{
            this.message='hello，arkts'
          })
        Image('https://img.picui.cn/free/2024/11/03/67277868edf0d.png')
          .width(250)
        //添加按钮，响应用户点击
        Button() {
          Text('Next')
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
        }
        .type(ButtonType.Capsule)
        .margin({
          top: 20
        })
        .backgroundColor('#0D9FFB')
        .width('40%')
        .height('5%')
        //跳转按钮，绑定onClick事件，点击时跳转第二页
        .onClick(() => {
          console.info('Succeeded in clicking the \'Next\' button')
          //跳转第二页
          router.pushUrl({ url: 'pages/Second' }).then(() => {
            console.info('Succeeded in jumping to the second page.')
          }).catch((err: BusinessError) => {
            console.error(`Failed to jump to the second page. Code is ${err.code}, message is ${err.message}`)
          })
        })
        Image($r('app.media.startIcon'))
          .width(50)
          .interpolation(ImageInterpolation.High)
      }
      .width('100%')  // 设置列的宽度为 100%
    }
    .height('100%')  // 设置行的高度为 100%
  }
}
