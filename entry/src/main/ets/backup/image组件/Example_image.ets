@Entry
@Component
struct Example {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('ExampleHelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Image('https://img.picui.cn/free/2024/11/03/67277868edf0d.png')
        .width(250)
    }
    .height('100%')
    .width('100%')
  }
}