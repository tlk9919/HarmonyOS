import {TaskStatistics} from '../views/task/TaskStatistics'
import {TaskList} from '../views/task/TaskList'
import { Header } from '../components/CommonComponets'

@Entry
@Component
struct  TaskManage {
  @State finishTask:number=0
  @State talkTask:number=0
  build() {
    Column({space:10}){

      Header()

      //任务进度卡片
      TaskStatistics({talkTask:this.talkTask,finishTask:this.finishTask})

      //任务列表
      TaskList({talkTask:$talkTask,finishTask:$finishTask})
    }
    .width('100%')
    .height('100%')
  }
}