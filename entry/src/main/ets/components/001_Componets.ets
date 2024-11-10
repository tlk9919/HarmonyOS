@Observed//对数组属性修改
class Task{
  static id:number=1//定义的属性是类的静态属性，它与类的所有实例共享。
  //任务名称
  name:string=`任务${Task.id++}`
  //任务状态：是否完成
  finished:boolean=false

}
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
// 任务完成样式
@Extend(Text)
function finishedTask() {
  .decoration({
    type: TextDecorationType.LineThrough//删除线
  })
  .fontColor('#B1B2B1')
}

@Component
 export  struct TsakStatistics {
   @Prop finishTask:number=0
  @Prop talkTask:number=0
  build() {
    Row() {
      Text('任务进度')
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
      //进度条
      // Progress 组件的基本定义和属性
      // 常见的属性：
      // value: （必需）当前的进度值。
      // total: （可选）总进度值，通常与 value 相比较，默认是 100。
      // type: （可选）进度条类型，可以选择环形进度条 (ProgressType.Ring) 或条形进度条 (ProgressType.Bar)。
      Stack() { //重叠容器
        Progress({
          value: this.finishTask,
          total: this.talkTask,
          type: ProgressType.Ring//环形
        })
          .width(100)
        Row() {
          Text(this.finishTask.toString())
            .fontSize(24)
            .fontColor('#36D')
          Text('/' + this.talkTask.toString())
            .fontSize(24)
        }
      }
    }
    .card()
    .justifyContent(FlexAlign.SpaceEvenly)
    .margin({ bottom: 20 })

  }
}


@Component
export  struct taskList  {
  //任务总量
  // 由“@Link”、“@Consume”和“@ObjectLink”修饰的变量无法在本地初始化。
  @Link talkTask: number
  //已经完成任务数量
  @Link finishTask: number
  @State tasks: Task[] = []//对数组的属性修改

  handleTaskChange() {
    //更新任务总数量
    this.talkTask = this.tasks.length
    //更新有已经完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length

  }
  build() {
Column(){

  //新增任务按钮
  Button('新增任务')
    .width(200)
    .onClick(() => {
      //新增任务数据
      this.tasks.push(new Task())
      //更新任务总数量
      this.handleTaskChange()
    })
  //任务列表
  List({ space: 10 }) { //List里面必须要跟ListItem，并且：ListItem之能有一个根组件
    ForEach(
      this.tasks,
      (item: Task, index) => {
        ListItem() {
          taskItem({item:item,onTaskChange:this.handleTaskChange.bind(this)})//bind 绑定taskList
        }
        .swipeAction({ end: this.DeleteButton(index) })

      }
    )
  }
  .width('100%')
  .layoutWeight(1) //弹性布局
  .alignListItem(ListItemAlign.Center) //通常用于对列表项进行对齐
}
  }

//用于渲染，要加@Builder
@Builder
DeleteButton(index: number) {
  Button() {
    Image($r('app.media.delete'))
      .width(20)
      .fillColor(Color.White)
  }
  .width(40)
  .height(40)
  .type(ButtonType.Circle)
  .backgroundColor(Color.Red) //枚举颜色
  .onClick(() => {
    this.tasks.splice(index, 1)
    this.handleTaskChange()
  })

}
}


@Component
//任务的一个项
export  struct taskItem {
  @ObjectLink item:Task
  onTaskChange:Function=()=>{}
  build() {
    Row() {
      //判断是否完成，加删除线
      if (this.item.finished){
        Text(this.item.name)
          .fontSize(20)
          .finishedTask()
      }
      else {
        Text(this.item.name)
          .fontSize(20)
      }
      Checkbox()
        .select(this.item.finished)
        .onChange(vaule => {
          //更新当前任务状态
          this.item.finished = vaule
          //更新有已经完成任务数量
          this.onTaskChange()
        })
    }
    .card()
    .justifyContent(FlexAlign.SpaceBetween)
  }
}