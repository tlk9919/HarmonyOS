import {TsakStatistics} from  '../components/001_Componets'
import {taskList} from  '../components/001_Componets'
//任务类
class Task{

  static id:number=1//定义的属性是类的静态属性，它与类的所有实例共享。
  //任务名称
  name:string=`任务${Task.id++}`
  //任务状态：是否完成
  finished:boolean=false
}

//统一卡片样式
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

@Entry
@Component
struct PropPage {
  //任务总量
  @State talkTask: number = 0
  //已经完成任务数量
  @State finishTask: number = 0
  //任务数组
  @State tasks: Task[] = []

  handleTaskChange() {
    //更新任务总数量
    this.talkTask = this.tasks.length
    //更新有已经完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length

  }

  build() {
    Column({ space: 8 }) {
      //任务进度卡片
      // @State组件不能同步父与子地数据
      TsakStatistics({ finishTask: this.finishTask, talkTask: this.talkTask })
      //任务列表
      taskList({finishTask: this.finishTask, talkTask: this.talkTask })

    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F1F2F3')

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


