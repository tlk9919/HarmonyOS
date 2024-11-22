// taskItem.ts
import { Task } from "../../components/001_Componets";  // 导入 Task 类
import TaskModel from "../../model/TaskModel";
import TaskInfo from "../../viewmodel/TaskInfo";

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
export struct taskItem {
  @ObjectLink item: TaskInfo;
  onTaskChange: Function = () => {};  // 任务状态改变时调用的回调函数

  build() {
    Row() {
      // 判断任务是否完成，若完成则加删除线
      if (this.item.finished) {
        Text(this.item.name)
          .fontSize(20)
          .finishedTask();  // 使用扩展的 finishedTask 样式
      } else {
        Text(this.item.name)
          .fontSize(20);
      }

      Checkbox()
        .select(this.item.finished)
        .onChange(async value => {
          try {
            await TaskModel.updateTaskStatus(this.item.id, value);  // 等待任务状态更新
            this.item.finished = value;  // 更新本地任务状态
            this.onTaskChange(this.item);  // 调用父组件的方法更新任务列表
          } catch (error) {
            console.log('testTag', `更新任务状态失败，id=${this.item.id}, 错误信息：`, JSON.stringify(error));
          }
        });
    }
    .card()  // 使用 card 样式
    .justifyContent(FlexAlign.SpaceBetween);  // 任务项内容左右对齐
  }
}
