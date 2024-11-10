@Entry
@Component
struct Columneg {
  @State imageWidth: number = 200;

  build() {
      Column(){
        // Image('https://img.picui.cn/free/2024/11/03/67277868edf0d.png')
        Row(){
          Image($r('app.media.startIcon'))
            .width(this.imageWidth)
            .interpolation(ImageInterpolation.High)//插值
        }
        .width('100%')
        .height(400)
        .width('100%')
        .justifyContent(FlexAlign.Center)
        Row(){
          Text($r('app.string.width_label'))
            .fontSize(20)
            .fontWeight(FontWeight.Bold)

          TextInput({ text: this.imageWidth.toFixed(0) })
            .width(150)
            .backgroundColor('#FFF')
            .type(InputType.Number)
            .onChange(value => this.imageWidth = parseInt(value))
        }
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)
        .padding({left:50,right:50})

        Divider()//下划线
          .width('90%')

        Row(){
          Button('缩小')
            .width(100)
            .height(60)
            .fontSize(30)
            .onClick(()=>{
              if(this.imageWidth>10)
                this.imageWidth-=10
            })
          Button('放大')
            .width(100)
            .height(60)
            .fontSize(30)
            // .type(ButtonType.Normal)
            .onClick(()=>{
              if(this.imageWidth<=800)
                this.imageWidth+=10
            })
        }
        .width('100%')
        .margin({
          top:30,
          bottom:30
        })
        .justifyContent(FlexAlign.SpaceEvenly)

        Slider({
          min:100,
          max:300,
          value:this.imageWidth,//默认滑块位置
          step:10
        })
          .width('100%')
          .blockColor('#36d')
          .trackThickness(10)//滑块粗细
          .showTips(true)//显示进度
          .onChange((vaule)=>{//事件方法
            this.imageWidth=vaule
          })
      }.width('100%')
    .height('100%')
  }
}