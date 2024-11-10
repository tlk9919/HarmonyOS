@Entry
@Component
struct Example {
  @State imageWidth: number = 200;

  build() {
    Row() {
      Column(){
        // Image('https://img.picui.cn/free/2024/11/03/67277868edf0d.png')
        Image($r('app.media.startIcon'))
          .width(this.imageWidth)
          .interpolation(ImageInterpolation.High)//插值
        // Text($r('app.string.width_label'))
        //   .fontSize(30)
        //   .fontWeight(FontWeight.Bold)
        Button('缩小')
          .width(150)
          .height(60)
          .fontSize(30)
          .onClick(()=>{
            if(this.imageWidth>10)
            this.imageWidth-=10
          })
        Button('放大')
          .width(150)
          .height(60)
          .fontSize(30)
          .type(ButtonType.Normal)
          .onClick(()=>{
            if(this.imageWidth<=800)
              this.imageWidth+=10
          })
        Slider({
          min:100,
          max:300,
          value:this.imageWidth,//默认滑块位置
          step:10
        })
          .width('90%')
          .blockColor('#36d')
          .trackThickness(10)//滑块粗细
          .showTips(true)//显示进度
          .onChange((vaule)=>{//事件方法
            this.imageWidth=vaule
          })
      }.width('100%')
    }
    .height('100%')
  }
}