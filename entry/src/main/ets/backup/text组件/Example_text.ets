@Entry
@Component
struct Example {
  @State message: string = 'Hello World';

  build() {
    Row() {
      Column(){
        // Image('https://img.picui.cn/free/2024/11/03/67277868edf0d.png')
        Image($r('app.media.startIcon'))
          .width(250)
        Text($r('app.string.width_label'))
          .fontSize(30)
          .fontWeight(FontWeight.Bold)

      }.width('100%')
    }
    .height('100%')
  }
}