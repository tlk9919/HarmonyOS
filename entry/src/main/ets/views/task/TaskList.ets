// taskList.ts
import TaskModel from '../../model/TaskModel';
import TaskInfo from '../../viewmodel/TaskInfo';
import { taskItem } from './taskItem';

@Component
export struct TaskList  {
  @Link talkTask: number;  // 任务总数量
  @Link finishTask: number;  // 已完成任务数量
  @State tasks: TaskInfo[] = [];  // 存储任务的数组

  aboutToAppear(): void {
    //查询任务列表
    console.log('testTag','初始化组件，查询任务列表')
    TaskModel.getTaskList()
      .then(tasks=>{
        this.tasks=tasks
        //更新任务状态
        this.handleTaskChange()
      })

  }


  handleTaskChange() {
    // 更新任务总数量
    this.talkTask = this.tasks.length;
    // 更新已完成任务数量
    this.finishTask = this.tasks.filter(item => item.finished).length;
  }

  handleAddTask(name: string) {
    // 1. 新增任务
    TaskModel.addTask(name)  // 使用类型断言
      .then(id => {
        console.log('testTag', '处理新增任务：', name);

        // 回显到数组页面
        this.tasks.push(new TaskInfo(id, name));

        // 2. 更新任务完成状态
        this.handleTaskChange();
      })
      .catch((error: Error) => {
        console.log('testTag', '新增任务失败：', name,JSON.stringify(error));
      });
  }



  build() {
    Column() {
      // 按钮：新增任务
      Button('新增任务')
        .width(200)
        .onClick(() => {
          this.tasks.push(new TaskInfo(0,''));  // 添加一个新的任务
          this.handleTaskChange();  // 更新任务总数和已完成任务数
        });

      // 显示任务列表
      List({ space: 10 }) {
        ForEach(this.tasks, (item: TaskInfo, index) => {
          ListItem() {
            taskItem({ item: item, onTaskChange: this.handleTaskChange.bind(this) });  // 渲染任务项
          }
          .swipeAction({ end: this.DeleteButton(index,item.id) });  // 删除按钮
        });
      }
      .width('100%')
      .layoutWeight(1)  // 弹性布局
      .alignListItem(ListItemAlign.Center);  // 列表项居中对齐
    }
  }

  @Builder
  DeleteButton(index: number, id: number) {
    Button() {
      Image($r('app.media.delete'))
        .width(20)
        .fillColor(Color.White);
    }
    .width(40)
    .height(40)
    .type(ButtonType.Circle)
    .backgroundColor(Color.Red)
    .onClick(() => {
      // 手动创建一个 Promise 来包装删除操作
      new Promise<void>((resolve, reject) => {
        try {
          // 调用原来的 deleteTaskById 方法
          TaskModel.deleteTaskById(id);

          // 如果删除操作成功，调用 resolve()
          resolve();
        } catch (error) {
          // 如果发生错误，调用 reject()
          reject(error);
        }
      })
        .then(() => {
          this.tasks.splice(index, 1);  // 删除任务
          this.handleTaskChange();  // 更新任务数量
        })
        .catch((error:Error) => {
          console.log('testTag', `删除任务失败，id=${id}, 错误信息：`, id,JSON.stringify(error));
        });
    });
  }

}
