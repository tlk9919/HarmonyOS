
@Styles
function card() {
  .width('95%')
  .padding(20)
  .backgroundColor(Color.White)
  .borderRadius(15)
  .shadow({
    radius: 6,
    color: '#1F000000',
    offsetX: 2,  // 阴影在 X 轴上向右偏移 2 像素
    offsetY: 4   // 阴影在 Y 轴上向下偏移 4 像素
  })
}
@Component
export struct TaskStatistics {
  @Prop finishTask: number = 0;  // 已完成任务数量
  @Prop talkTask: number = 0;  // 总任务数量

  build() {
    Row() {
      Text('任务进度')
        .fontSize(30)
        .fontWeight(FontWeight.Bold);

      Stack() {  // 重叠容器
        Progress({
          value: this.finishTask,
          total: this.talkTask,
          type: ProgressType.Ring  // 环形进度条
        })
          .width(100);

        Row() {
          Text(this.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D');
          Text('/' + this.talkTask.toString())
            .fontSize(24);
        }
      }
    }
    .card()  // 使用 card 样式
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ bottom: 20 });
  }
}
